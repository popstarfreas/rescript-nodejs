open Zora

let repoRoot = Process.cwd(Process.process)
let readSource = path =>
  Fs.readFileSync(path)->Buffer.toStringWithEncoding(StringEncoding.utf8)
let contains = (haystack, needle) => String.indexOf(haystack, needle) >= 0

zoraBlock("Url", t => {
  let src = readSource(Path.join2(repoRoot, "src/Url.res"))
  t->block("Url.port should be string", t => {
    t->ok(!contains(src, "port: int"), "URL.port should not be int")
  })
})
