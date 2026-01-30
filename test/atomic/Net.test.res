open Zora

let repoRoot = Process.cwd(Process.process)
let readSource = path =>
  Fs.readFileSync(path)->Buffer.toStringWithEncoding(StringEncoding.utf8)
let contains = (haystack, needle) => String.indexOf(haystack, needle) >= 0

zoraBlock("Net", t => {
  t->block("isIP should return int, not bool", t => {
    let resultV4 = Net.isIP("127.0.0.1")
    let resultV6 = Net.isIP("::1")
    let resultInvalid = Net.isIP("not-an-ip")

    let v4Int: int = Obj.magic(resultV4)
    let v6Int: int = Obj.magic(resultV6)
    let invalidInt: int = Obj.magic(resultInvalid)

    t->equal(v4Int, 4, "isIP('127.0.0.1') should return 4")
    t->equal(v6Int, 6, "isIP('::1') should return 6")
    t->equal(invalidInt, 0, "isIP('not-an-ip') should return 0")
  })

  t->block("Server.onError should pass JsExn.t", t => {
    let src = readSource(Path.join2(repoRoot, "src/Net.res"))
    t->ok(
      !contains(src, "onError: (subtype<'ty>, @as(\"error\") _, @uncurry unit => unit)"),
      "Server.onError should receive JsExn.t",
    )
  })
})
