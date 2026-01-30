open Zora

let repoRoot = Process.cwd(Process.process)
let readSource = path =>
  Fs.readFileSync(path)->Buffer.toStringWithEncoding(StringEncoding.utf8)
let contains = (haystack, needle) => String.indexOf(haystack, needle) >= 0

zoraBlock("Http", t => {
  let src = readSource(Path.join2(repoRoot, "src/Http.res"))

  t->block("IncomingMessage should not expose port", t => {
    t->ok(
      !contains(src, "@get external port: subtype<'r, 'a> => int = \"port\""),
      "IncomingMessage.port should not exist",
    )
  })

  t->block("contentLength should be spelled correctly", t => {
    t->ok(!contains(src, "contentLenth"), "contentLength is misspelled")
  })

  t->block("accessControlAllowMethods should be option", t => {
    t->ok(
      !contains(src, "accessControlAllowMethods: string"),
      "accessControlAllowMethods should be option<string>",
    )
  })

  t->block("_STATUS_CODES/_METHODS should not be duplicated", t => {
    let hasStatusCodesDict = contains(src, "external _STATUS_CODES: dict<string>")
    let hasStatusCodesAlias = contains(src, "external _STATUS_CODES: statusCodes")
    t->ok(
      !(hasStatusCodesDict && hasStatusCodesAlias),
      "_STATUS_CODES should not be declared twice",
    )

    let hasMethodsArray = contains(src, "external _METHODS: array<string>")
    let hasMethodsAlias = contains(src, "external _METHODS: methods")
    t->ok(
      !(hasMethodsArray && hasMethodsAlias),
      "_METHODS should not be declared twice",
    )
  })
})
