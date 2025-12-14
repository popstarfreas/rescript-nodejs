open Zora

zoraBlock("Os", t => {
  t->block("Should be able to get the network interfaces", t => {
    let ifaces = Os.networkInterfaces()
    t->notEqual(Dict.keysToArray(ifaces)->Array.length, 0, "")
    t->equal(Dict.get(ifaces, "lo")->Option.isSome, true, "")
    let localhost = (
      Dict.get(ifaces, "lo")->Option.getOrThrow->Array.get(0)->Option.getOrThrow
    ).address
    t->equal(localhost, "127.0.0.1", "")
    Stdlib.Console.log(ifaces)
  })
})
