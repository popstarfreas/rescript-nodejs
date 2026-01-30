open Zora

let repoRoot = Process.cwd(Process.process)
let readSource = path =>
  Fs.readFileSync(path)->Buffer.toStringWithEncoding(StringEncoding.utf8)
let contains = (haystack, needle) => String.indexOf(haystack, needle) >= 0

zoraBlock("Util.Types", t => {
  t->block("Util.Types.isAnyArrayBuffer(arrayBuffer) should return true", t => {
    let arrayBuffer = Js.TypedArray2.ArrayBuffer.make(16)
    t->equal(arrayBuffer->Util.Types.isAnyArrayBuffer, true, "")
  })

  t->block("Util.Types.isAnyArrayBuffer(string) should return false", t => {
    let str = "not array buffer"
    t->equal(str->Util.Types.isAnyArrayBuffer, false, "")
  })

  t->block("Util module should use node:util prefix", t => {
    let src = readSource(Path.join2(repoRoot, "src/Util.res"))
    t->ok(!contains(src, "@module(\"util\")"), "Util bindings should use node:util")
  })
})
