open Zora

let repoRoot = Process.cwd(Process.process)
let readSource = path =>
  Fs.readFileSync(path)->Buffer.toStringWithEncoding(StringEncoding.utf8)
let contains = (haystack, needle) => String.indexOf(haystack, needle) >= 0

zora("Dns", async t => {
  t->test("Dns.lookup should not throw (scope typo)", async t => {
    try {
      let _ = await Dns.lookup("localhost")
      t->ok(true, "Dns.lookup should resolve without error")
    } catch {
    | JsExn(e) =>
      t->fail(
        "Dns.lookup threw: " ++ JsExn.message(e)->Option.getOr("unknown"),
      )
    }
  })

  t->block("CallbackAPI resolve* callbacks should be functions", t => {
    let src = readSource(Path.join2(repoRoot, "src/Dns.res"))
    t->ok(
      !contains(
        src,
        "external resolveMx: (string, (JsExn.t, array<{\"exchange\": string, \"priority\": int}>)) => unit",
      ),
      "resolveMx callback should be a function",
    )
    t->ok(
      !contains(src, "external resolveNs: (string, (JsExn.t, array<string>)) => unit"),
      "resolveNs callback should be a function",
    )
    t->ok(
      !contains(src, "external resolvePtr: (string, (JsExn.t, array<string>)) => unit"),
      "resolvePtr callback should be a function",
    )
    t->ok(
      !contains(src, "external resolveTxt: (string, (JsExn.t, array<array<string>>)) => unit"),
      "resolveTxt callback should be a function",
    )
  })
})
