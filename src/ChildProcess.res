type t = {
  connected: bool,
  killed: bool,
  pid: int,
  exitCode: int,
}

module Events = {
  @send
  external onData: (t, @as("data") _, @uncurry (Buffer.t => unit)) => t = "on"
  @send
  external onDisconnect: (t, @as("disconnect") _, @uncurry unit => unit) => t = "on"
  @send
  external onError: (t, @as("error") _, @uncurry (Js.Exn.t => unit)) => t = "on"
  @send
  external onExit: (t, @as("exit") _, @uncurry (Js.Null.t<int>, Js.Null.t<string>) => unit) => t =
    "on"
  @send
  external onClose: (t, @as("close") _, @uncurry int => unit) => t = "on"

  @send
  external offData: (t, @as("data") _, @uncurry (Buffer.t => unit)) => t = "off"
  @send
  external offDisconnect: (t, @as("disconnect") _, @uncurry unit => unit) => t = "off"
  @send
  external offError: (t, @as("error") _, @uncurry (Js.Exn.t => unit)) => t = "off"
  @send
  external offExit: (t, @as("exit") _, @uncurry int => unit) => t = "off"
  @send
  external offClose: (t, @as("close") _, @uncurry int => unit) => t = "off"

  @send
  external onDataOnce: (t, @as("data") _, @uncurry (Buffer.t => unit)) => t = "once"
  @send
  external onDisconnectOnce: (t, @as("disconnect") _, @uncurry unit => unit) => t = "once"
  @send
  external onErrorOnce: (t, @as("error") _, @uncurry (Js.Exn.t => unit)) => t = "once"
  @send
  external onExitOnce: (
    t,
    @as("exit") _,
    @uncurry (Js.Null.t<int>, Js.Null.t<string>) => unit,
  ) => t = "once"
  @send
  external onCloseOnce: (t, @as("close") _, @uncurry int => unit) => t = "once"

  @send
  external emitData: (t, @as("data") _, Buffer.t) => bool = "emit"
  @send
  external emitDisconnect: (t, @as("disconnect") _) => bool = "emit"
  @send
  external emitError: (t, @as("error") _, Js.Exn.t) => bool = "emit"
  @send external emitExit: (t, @as("exit") _, int) => bool = "emit"
  @send external emitClose: (t, @as("close") _, int) => bool = "emit"

  @send external removeAllListeners: t => t = "removeAllListeners"
  @send
  external removeExitListener: (
    t,
    @as("exit") _,
    @uncurry (Js.Null.t<int>, Js.Null.t<string>) => unit,
  ) => unit = "removeListener"
  @send
  external removeErrorListener: (t, @as("error") _, @uncurry (Js.Exn.t => unit)) => unit =
    "removeListener"
  @send
  external removeCloseListener: (t, @as("close") _, @uncurry (int => unit)) => unit =
    "removeListener"
  @send
  external removeDisconnectListener: (t, @as("disconnect") _, @uncurry (unit => unit)) => unit =
    "removeListener"
}
include Events

@get external connected: t => bool = "connected"
@send external disconnect: t => bool = "disconnect"
@send external kill: (t, string) => unit = "kill"
@send external ref: t => unit = "ref"
@send external unref: t => unit = "unref"
@get external killed: t => bool = "killed"
@get external pid: t => int = "pid"
@get @return(nullable)
external stderr: t => option<Stream.Readable.t<Buffer.t>> = "stderr"
@get @return(nullable)
external stdin: t => option<Stream.Writable.t<Buffer.t>> = "stdin"
@get @return(nullable)
external stdout: t => option<Stream.Readable.t<Buffer.t>> = "stdout"

type execOptions = {
  cwd?: string,
  env?: Js.Dict.t<string>,
  shell?: string,
  timeout?: int,
  maxBuffer?: int,
  killSignal?: string,
  uid?: int,
  gid?: int,
  windowsHide?: bool,
  unit: unit,
}

@module("node:child_process") @val
external exec: (string, (Js.nullable<Js.Exn.t>, Buffer.t, Buffer.t) => unit) => t = "exec"

@module("node:child_process") @val
external execWith: (string, execOptions, (Js.nullable<Js.Exn.t>, Buffer.t, Buffer.t) => unit) => t =
  "exec"

type execFileOptions = {
  cwd?: string,
  env?: Js.Dict.t<string>,
  timeout?: int,
  maxBuffer?: int,
  killSignal?: string,
  uid?: int,
  gid?: int,
  windowsHide?: bool,
  shell?: string,
}

@module("node:child_process") @val
external execFile: (
  string,
  array<string>,
  (Js.nullable<Js.Exn.t>, Buffer.t, Buffer.t) => unit,
) => t = "execFile"

@module("node:child_process") @val
external execFileWith: (
  string,
  array<string>,
  execFileOptions,
  (Js.nullable<Js.Exn.t>, Buffer.t, Buffer.t) => unit,
) => t = "execFile"

type stdioPipeSetting = [
  | #pipe
  | #overlapped
  | #ignore
  | #inherit
]

type stdio = (stdioPipeSetting, stdioPipeSetting, stdioPipeSetting)

let stdioPipe: stdio = (#pipe, #pipe, #pipe)
let stdioOverlapped: stdio = (#overlapped, #overlapped, #overlapped)
let stdioIgnore: stdio = (#ignore, #ignore, #ignore)
let stdioInherit: stdio = (#inherit, #inherit, #inherit)

type forkOptions = {
  cwd?: string,
  detached?: bool,
  env?: Js.Dict.t<string>,
  execPath?: string,
  execArgv?: array<string>,
  silent?: bool,
  stdio?: stdio,
  uid?: int,
  gid?: int,
  windowsVerbatimArguments?: bool,
}

@module("node:child_process") @val
external fork: (string, array<string>) => t = "fork"

@module("node:child_process") @val
external forkWith: (string, array<string>, forkOptions) => t = "fork"

type spawnOptions = {
  cwd?: string,
  env?: Js.Dict.t<string>,
  argv0?: string,
  stdio?: stdio,
  detached?: bool,
  uid?: int,
  gid?: int,
  shell?: string,
  windowsVerbatimArguments?: bool,
  windowsHide?: bool,
}

external spawn: (string, array<string>) => t = "spawn"

@module("node:child_process") @val
external spawnWith: (string, array<string>, spawnOptions) => t = "spawn"

type spawnSyncResult<'a> = {
  pid: int,
  output: array<'a>,
  stdout: Buffer.t,
  stderr: Buffer.t,
  status: int,
  signal: Js.nullable<string>,
  error: Js.nullable<Js.Exn.t>,
}

type spawnSyncOptions = {
  cwd?: string,
  env?: Js.Dict.t<string>,
  input?: Buffer.t,
  argv0?: string,
  stdio?: stdio,
  detached?: bool,
  uid?: int,
  gid?: int,
  shell?: string,
  windowsVerbatimArguments?: bool,
  windowsHide?: bool,
}

@module("node:child_process") @val
external spawnSync: (string, array<string>, spawnSyncOptions) => spawnSyncResult<'a> = "spawnSync"

@module("node:child_process") @val
external spawnSyncWith: (string, array<string>, spawnSyncOptions) => spawnSyncResult<'a> =
  "spawnSync"

type execSyncOptions = {
  cwd?: string,
  env?: Js.Dict.t<string>,
  input?: Buffer.t,
  shell?: string,
  timeout?: int,
  maxBuffer?: int,
  killSignal?: string,
  uid?: int,
  gid?: int,
  stdio?: stdio,
  windowsHide?: bool,
}

@module("node:child_process") @val
external execSync: string => Buffer.t = "execSync"

@module("node:child_process") @val
external execSyncWith: (string, execSyncOptions) => Buffer.t = "execSync"

type execFileSyncOptions = {
  cwd?: string,
  env?: Js.Dict.t<string>,
  input?: Buffer.t,
  shell?: string,
  timeout?: int,
  maxBuffer?: int,
  killSignal?: string,
  uid?: int,
  gid?: int,
  windowsHide?: bool,
}

@module("node:child_process") @val
external execFileSync: (string, array<string>) => Buffer.t = "execFileSync"

@module("node:child_process") @val
external execFileSyncWith: (string, array<string>, execFileSyncOptions) => Buffer.t = "execFileSync"
