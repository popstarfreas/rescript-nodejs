open Fs
open Zora

let repoRoot = Process.cwd(Process.process)
let readSource = path =>
  Fs.readFileSync(path)->Buffer.toStringWithEncoding(StringEncoding.utf8)
let contains = (haystack, needle) => String.indexOf(haystack, needle) >= 0

zora("Fs", async t => {
  t->test("readFile should read entire file", async t => {
    let fh = await open_(Global.filename(Global.importMetaUrl), Flag.read)
    let buffer = await FileHandle.readFile(fh)
    let _ = await FileHandle.close(fh)

    let needle = "Random string: Gh2e71pdHhPxU"
    t->ok(buffer->Buffer.indexOfString(needle) > 1, "buffer index was not greater than zero")
  })

  t->test("readFileWith should read entire file as a string", async t => {
    let fh = await open_(Global.filename(Global.importMetaUrl), Flag.read)
    let buffer = await FileHandle.readFileWith(fh, {encoding: "UTF-8"})
    let _ = await FileHandle.close(fh)
    let needle = "Random string: uCF6c5f3Arrq"

    t->ok(String.indexOf(buffer, needle) > 0, "buffer string indexOf was not greater than zero")
  })

  t->test("watch should emit change events via listener", t =>
    Promise.make((resolve, _) => {
      let unique = "rescript-nodejs-fs-watch-" ++ Int.toString(Process.pid(Process.process))
      let dir = Path.join2(Os.tmpdir(), unique ++ "-listener")
      let filePath = Path.join2(dir, "watch-listener.txt")
      let done = ref(false)
      let watcherRef: ref<option<FSWatcher.t>> = ref(None)

      let cleanup = () => {
        if existsSync(filePath) {
          unlinkSync(filePath)
        }
        if existsSync(dir) {
          rmdirSync(dir)
        }
      }

      if existsSync(filePath) {
        unlinkSync(filePath)
      }
      if existsSync(dir) {
        rmdirSync(dir)
      }
      mkdirSync(dir)
      writeFileSync(filePath, Buffer.fromString("initial"))

      let finish = (passed, message) => {
        if !done.contents {
          done := true
          switch watcherRef.contents {
          | Some(watcher) => watcher->FSWatcher.close
          | None => ()
          }
          cleanup()
          t->ok(passed, message)
          resolve()
        }
      }

      let watcher =
        watch(
          filePath,
          ~listener=(eventType, _filename) => {
            finish(eventType == #change || eventType == #rename, "")
          },
          (),
        )
      watcherRef := Some(watcher)

      setTimeout(() => {
        finish(false, "watch did not emit a change event in time")
      }, 1500)->ignore

      writeFileSync(filePath, Buffer.fromString("updated"))
    })
  )

  t->test("watchWithOptions should allow registering change handlers", t =>
    Promise.make((resolve, _) => {
      let unique = "rescript-nodejs-fs-watch-" ++ Int.toString(Process.pid(Process.process))
      let dir = Path.join2(Os.tmpdir(), unique ++ "-options")
      let filePath = Path.join2(dir, "watch-options.txt")
      let done = ref(false)

      let cleanup = () => {
        if existsSync(filePath) {
          unlinkSync(filePath)
        }
        if existsSync(dir) {
          rmdirSync(dir)
        }
      }

      if existsSync(filePath) {
        unlinkSync(filePath)
      }
      if existsSync(dir) {
        rmdirSync(dir)
      }
      mkdirSync(dir)
      writeFileSync(filePath, Buffer.fromString("initial"))

      let watcher =
        watchWithOptions(
          filePath,
          {persistent: false, recursive: false, encoding: "utf8"},
          (),
        )

      watcher->FSWatcher.onChange((eventType, _filename) => {
        if !done.contents {
          done := true
          watcher->FSWatcher.close
          cleanup()
          t->ok(eventType == #change || eventType == #rename, "")
          resolve()
        }
      })->ignore

      setTimeout(() => {
        if !done.contents {
          done := true
          watcher->FSWatcher.close
          cleanup()
          t->ok(false, "watchWithOptions did not emit a change event in time")
          resolve()
        }
      }, 1500)->ignore

      writeFileSync(filePath, Buffer.fromString("updated"))
    })
  )

  t->test("mkdtemp should not throw", async t => {
    let prefix = Path.join2(Os.tmpdir(), "rescript-test-")
    try {
      let dir = await Fs.mkdtemp(prefix)
      Fs.rmdirSync(dir)
      t->ok(true, "mkdtemp should work without error")
    } catch {
    | JsExn(e) =>
      t->fail(
        "mkdtemp threw: " ++ JsExn.message(e)->Option.getOr("unknown"),
      )
    }
  })

  t->test("PromiseAPI.mkdtempWith should not throw", async t => {
    let prefix = Path.join2(Os.tmpdir(), "rescript-test-with-")
    try {
      let dir = await Fs.PromiseAPI.mkdtempWith(~prefix, ~mkdtempOptions=#Str("utf8"))
      Fs.rmdirSync(dir)
      t->ok(true, "mkdtempWith should work without error")
    } catch {
    | JsExn(e) =>
      t->fail(
        "mkdtempWith threw: " ++ JsExn.message(e)->Option.getOr("unknown"),
      )
    }
  })

  t->test("mkdtempWith (top-level) should not throw", async t => {
    let prefix = Path.join2(Os.tmpdir(), "rescript-test-with-top-")
    try {
      let dir = await Fs.mkdtempWith(prefix, {encoding: "utf8"})
      Fs.rmdirSync(dir)
      t->ok(true, "mkdtempWith should work without error")
    } catch {
    | JsExn(e) =>
      t->fail(
        "mkdtempWith threw: " ++ JsExn.message(e)->Option.getOr("unknown"),
      )
    }
  })

  t->test("PromiseAPI.stat should follow symlinks", async t => {
    let prefix = Path.join2(Os.tmpdir(), "rescript-stat-test-")
    let dir = await Fs.PromiseAPI.mkdtemp(prefix)
    let filePath = Path.join2(dir, "target.txt")
    let linkPath = Path.join2(dir, "link.txt")

    Fs.writeFileSync(filePath, Buffer.fromString("hello"))
    Fs.symlinkSync(filePath, linkPath)

    let result = await Fs.PromiseAPI.stat(#Str(linkPath))
    t->equal(
      Fs.Stats.isSymbolicLink(result),
      false,
      "stat should follow symlinks (isSymbolicLink == false)",
    )

    Fs.unlinkSync(linkPath)
    Fs.unlinkSync(filePath)
    Fs.rmdirSync(dir)
  })

  t->test("ReadStream.bytesRead should return bytes read", t =>
    Promise.make((resolve, _) => {
      let filePath = Global.filename(Global.importMetaUrl)
      let rs = Fs.createReadStream(filePath)

      rs
      ->Stream.Readable.onEnd(() => {
        try {
          let reported = Fs.ReadStream.bytesRead(rs)
          t->ok(reported > 0, "bytesRead should be > 0 after fully reading the stream")
          resolve()
        } catch {
        | JsExn(e) =>
          t->fail(
            "bytesRead threw: " ++ JsExn.message(e)->Option.getOr("unknown"),
          )
          resolve()
        }
      })
      ->ignore

      rs->Stream.Readable.resume->ignore
    })
  )

  t->block("Stats time fields should be Date.t not string", t => {
    let fsSource = readSource(Path.join2(repoRoot, "src/Fs.res"))
    t->ok(!contains(fsSource, "atime: string"), "Stats.atime should not be string")
    t->ok(!contains(fsSource, "mtime: string"), "Stats.mtime should not be string")
    t->ok(!contains(fsSource, "ctime: string"), "Stats.ctime should not be string")
    t->ok(!contains(fsSource, "birthtime: string"), "Stats.birthtime should not be string")
  })

  t->block("statOptions.bigint should be bool", t => {
    let fsSource = readSource(Path.join2(repoRoot, "src/Fs.res"))
    t->ok(
      !contains(fsSource, "type statOptions = {bigint: int}"),
      "statOptions.bigint should not be int",
    )
  })

  t->block("Stats doc comments should match function name", t => {
    let fsSource = readSource(Path.join2(repoRoot, "src/Fs.res"))
    t->ok(
      !contains(
        fsSource,
        "`isBlockDevice(stats)` Returns true if the `stats` object describes a character device.",
      ),
      "isCharacterDevice doc comment should not say isBlockDevice",
    )
    t->ok(
      !contains(
        fsSource,
        "`isBlockDevice(stats)` Returns true if the `stats` object describes a symbolic link.",
      ),
      "isSymbolicLink doc comment should not say isBlockDevice",
    )
    t->ok(
      !contains(
        fsSource,
        "`isBlockDevice(stats)` Returns true if the `stats` object describes a first-in-first-out (FIFO) pipe.",
      ),
      "isFIFO doc comment should not say isBlockDevice",
    )
    t->ok(
      !contains(
        fsSource,
        "`isBlockDevice(stats)` Returns true if the `stats` object describes a socket.",
      ),
      "isSocket doc comment should not say isBlockDevice",
    )
  })

  t->block("FileHandle.appendFile naming should be consistent", t => {
    let fsSource = readSource(Path.join2(repoRoot, "src/Fs.res"))
    t->ok(
      !contains(fsSource, "external appendFile: (t, Buffer.t, appendFileOptions)"),
      "appendFile should not require options while appendFileWith does not",
    )
    t->ok(
      !contains(fsSource, "external appendFileWith: (t, Buffer.t)"),
      "appendFileWith should accept options",
    )
  })

  t->block("Module path prefixes should use node:fs", t => {
    let fsSource = readSource(Path.join2(repoRoot, "src/Fs.res"))
    t->ok(!contains(fsSource, "@module(\"fs\")"), "Fs bindings should use node:fs")
  })
})
