module Immediate = {
  type t
  @send external hasRef: t => bool = "hasRef"
  @send external ref: t => t = "ref"
  @send external unref: t => t = "unref"
}

module Timeout = {
  type t
  @send external hasRef: t => bool = "hasRef"
  @send external ref: t => t = "ref"
  @send external refresh: t => t = "refresh"
  @send external unref: t => t = "unref"
}

@val
external setImmediate: (unit => unit) => Immediate.t = "setImmediate"
@val external setTimeout: (unit => unit, int) => Timeout.t = "setTimeout"
@val
external setInterval: (unit => unit, int) => Timeout.t = "setInterval"
@val external clearImmediate: Immediate.t => unit = "clearImmediate"
@val external clearTimeout: Timeout.t => unit = "clearTimeout"
@val external clearInterval: Timeout.t => unit = "clearInterval"
