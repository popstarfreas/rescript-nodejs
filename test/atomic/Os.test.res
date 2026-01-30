open Zora

let repoRoot = Process.cwd(Process.process)
let readSource = path =>
  Fs.readFileSync(path)->Buffer.toStringWithEncoding(StringEncoding.utf8)
let contains = (haystack, needle) => String.indexOf(haystack, needle) >= 0

zoraBlock("Os", t => {
  t->block("Should be able to get the network interfaces", t => {
    let ifaces = Os.networkInterfaces()
    t->notEqual(Dict.keysToArray(ifaces)->Array.length, 0, "")
    t->equal(Dict.get(ifaces, "lo")->Option.isSome, true, "")
    let localhost = (
      Dict.get(ifaces, "lo")->Option.getOrThrow->Array.get(0)->Option.getOrThrow
    ).address
    t->equal(localhost, "127.0.0.1", "")
  })

  t->block("cpu.speed should be int", t => {
    let src = readSource(Path.join2(repoRoot, "src/Os.res"))
    t->ok(!contains(src, "speed: string"), "cpu.speed should not be string")
  })

  t->block("freemem/totalmem should be float", t => {
    let src = readSource(Path.join2(repoRoot, "src/Os.res"))
    t->ok(!contains(src, "external freemem: unit => int"), "freemem should not be int")
    t->ok(!contains(src, "external totalmem: unit => int"), "totalmem should not be int")
  })
})
