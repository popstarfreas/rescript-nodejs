open Fs
open Zora

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

      let finish = (ok, message) => {
        if !done.contents {
          done := true
          switch watcherRef.contents {
          | Some(watcher) => watcher->FSWatcher.close
          | None => ()
          }
          cleanup()
          t->ok(ok, message)
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
})
