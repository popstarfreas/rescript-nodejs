open Zora

zoraBlock("Os", t => {
  t->block("Should be able to get the network interfaces", t => {
    let ifaces = Os.networkInterfaces()
    t->notEqual(Js.Dict.keys(ifaces)->Js.Array2.length, 0, "")
    t->equal(Js.Dict.get(ifaces, "lo")->Belt.Option.isSome, true, "")
    let localhost = (Js.Dict.get(ifaces, "lo")->Belt.Option.getExn->Belt.Array.getExn(0)).address
    t->equal(localhost, "127.0.0.1", "")
  })
})
