open Zora

let repoRoot = Process.cwd(Process.process)
let readSource = path =>
  Fs.readFileSync(path)->Buffer.toStringWithEncoding(StringEncoding.utf8)
let contains = (haystack, needle) => String.indexOf(haystack, needle) >= 0

zora("Buffer", async t => {
  t->test("readIntBE should accept both offset and length", async t => {
    let buf = Buffer.fromArray([0x01, 0x02, 0x03, 0x04])
    try {
      let _ = Buffer.readIntBE(buf, ~offset=0, ~length=4)
      t->ok(true, "readIntBE should not throw")
    } catch {
    | JsExn(e) =>
      t->fail(
        "readIntBE threw: " ++ JsExn.message(e)->Option.getOr("unknown"),
      )
    }
  })

  t->block("Buffer constants should be module-level", t => {
    let src = readSource(Path.join2(repoRoot, "src/Buffer.res"))
    t->ok(
      !contains(src, "@get external _INSPECT_MAX_BYTES: t => int"),
      "INSPECT_MAX_BYTES should not be an instance getter",
    )
    t->ok(
      !contains(src, "@get external kMaxLength: t => int"),
      "kMaxLength should not be an instance getter",
    )
  })

  t->test("ucs2 encoding should be recognised by Node.js", async t => {
    try {
      let buf = Buffer.fromStringWithEncoding("hello", StringEncoding.ucs2)
      let _ = Buffer.toStringWithEncoding(buf, StringEncoding.ucs2)
      t->ok(true, "ucs2 encoding should be recognised by Node.js")
    } catch {
    | JsExn(e) =>
      t->fail(
        "ucs2 encoding threw: " ++ JsExn.message(e)->Option.getOr("unknown"),
      )
    }
  })
})
