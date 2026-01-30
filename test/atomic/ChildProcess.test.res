open Zora

let repoRoot = Process.cwd(Process.process)
let readSource = path =>
  Fs.readFileSync(path)->Buffer.toStringWithEncoding(StringEncoding.utf8)
let contains = (haystack, needle) => String.indexOf(haystack, needle) >= 0

zora("ChildProcess", async t => {
  t->test("spawn should not throw ReferenceError", async t => {
    try {
      let cp = ChildProcess.spawn("echo", ["hello"])
      cp->ChildProcess.kill("SIGTERM")
      t->ok(true, "spawn should work without error")
    } catch {
    | JsExn(e) =>
      t->fail(
        "spawn threw: " ++ JsExn.message(e)->Option.getOr("unknown"),
      )
    }
  })

  t->block("offExit should match onExit signature", t => {
    let src = readSource(Path.join2(repoRoot, "src/ChildProcess.res"))
    t->ok(
      !contains(src, "offExit: (t, @as(\"exit\") _, @uncurry int => unit)"),
      "offExit should accept (Null.t<int>, Null.t<string>)",
    )
  })

  t->block("disconnect should return unit", t => {
    let src = readSource(Path.join2(repoRoot, "src/ChildProcess.res"))
    t->ok(
      !contains(src, "external disconnect: t => bool = \"disconnect\""),
      "disconnect should not return bool",
    )
  })

  t->block("execOptions should not include unit field", t => {
    let src = readSource(Path.join2(repoRoot, "src/ChildProcess.res"))
    t->ok(!contains(src, "unit: unit"), "execOptions should not include unit")
  })

  t->block("spawnSync and spawnSyncWith should differ", t => {
    let src = readSource(Path.join2(repoRoot, "src/ChildProcess.res"))
    let hasSpawnSync =
      contains(src, "external spawnSync: (string, array<string>, spawnSyncOptions)")
    let hasSpawnSyncWith =
      contains(src, "external spawnSyncWith: (string, array<string>, spawnSyncOptions)")
    t->ok(
      !(hasSpawnSync && hasSpawnSyncWith),
      "spawnSync and spawnSyncWith should not have identical signatures",
    )
  })
})
