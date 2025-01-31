module Dirent = {
  type t = {name: string}
  @send external isBlockDevice: t => bool = "isBlockDevice"
  @send external isCharacterDevice: t => bool = "isCharacterDevice"
  @send external isDirectory: t => bool = "isDirectory"
  @send external isFIFO: t => bool = "isFIFO"
  @send external isFile: t => bool = "isFile"
  @send external isSocket: t => bool = "isSocket"
  @send external isSymbolicLink: t => bool = "isSymbolicLink"
}

module Dir = {
  type t = {path: string}
  @send external close: t => Js.Promise.t<unit> = "close"
  @send
  external closeWithCallback: (t, Js.nullable<Js.Exn.t> => unit) => unit = "close"
  @send external closeSync: t => unit = "closeSync"
  @send
  external read: t => Js.Promise.t<Js.nullable<Dirent.t>> = "read"
  @send
  external readWithCallback: (t, (Js.Exn.t, Js.nullable<Dirent.t>) => unit) => unit = "read"
  @send external readSync: t => Js.nullable<Dirent.t> = "readSync"
}

module Stats = {
  type t = {
    dev: int,
    ino: int,
    mode: int,
    nlink: int,
    uid: int,
    gid: int,
    rdev: int,
    size: int,
    blksize: int,
    blocks: int,
    atimeMs: float,
    mtimeMs: float,
    ctimeMs: float,
    birthtimeMs: float,
    atime: string,
    mtime: string,
    ctime: string,
    birthtime: string,
  }

  /** `isFile(stats)` Returns true if the `stats` object describes a file. */
  @send
  external isFile: t => bool = "isFile"
  /** `isDirectory(stats)` Returns true if the `stats` object describes a directory. */
  @send
  external isDirectory: t => bool = "isDirectory"
  /** `isBlockDevice(stats)` Returns true if the `stats` object describes a block device. */
  @send
  external isBlockDevice: t => bool = "isBlockDevice"
  /** `isBlockDevice(stats)` Returns true if the `stats` object describes a character device. */
  @send
  external isCharacterDevice: t => bool = "isCharacterDevice"
  /** `isBlockDevice(stats)` Returns true if the `stats` object describes a symbolic link. */
  @send
  external isSymbolicLink: t => bool = "isSymbolicLink"
  /** `isBlockDevice(stats)` Returns true if the `stats` object describes a first-in-first-out (FIFO) pipe. */
  @send
  external isFIFO: t => bool = "isFIFO"
  /** `isBlockDevice(stats)` Returns true if the `stats` object describes a socket. */
  @send
  external isSocket: t => bool = "isSocket"
}

module Constants = {
  type t = private int

  /** Bitwise 'or' i.e. JavaScript [x | y] */
  external lor: (t, t) => t = "%orint"

  @@text("{1 File Access Constants}")

  @module("node:fs") @scope("constants") external f_ok: t = "F_OK"
  @module("node:fs") @scope("constants") external w_ok: t = "W_OK"
  @module("node:fs") @scope("constants") external r_ok: t = "R_OK"
  @module("node:fs") @scope("constants") external x_ok: t = "X_OK"

  @@text("{1 File Copy Constants}")

  @module("node:fs") @scope("constants") external copyfile_excl: t = "COPYFILE_EXCL"
  @module("node:fs") @scope("constants") external copyfile_ficlone: t = "COPYFILE_FICLONE"
  @module("node:fs") @scope("constants")
  external copyfile_ficlone_force: t = "COPYFILE_FICLONE_FORCE"

  @@text("{1 File Open Constants}")

  @module("node:fs") @scope("constants") external o_rdonly: t = "O_RDONLY"
  @module("node:fs") @scope("constants") external o_wronly: t = "O_WRONLY"
  @module("node:fs") @scope("constants") external o_rdwr: t = "O_RDWR"
  @module("node:fs") @scope("constants") external o_creat: t = "O_CREAT"
  @module("node:fs") @scope("constants") external o_excl: t = "O_EXCL"
  @module("node:fs") @scope("constants") external o_noctty: t = "O_NOCTTY"
  @module("node:fs") @scope("constants") external o_trunc: t = "O_TRUNC"
  @module("node:fs") @scope("constants") external o_append: t = "O_APPEND"
  @module("node:fs") @scope("constants") external o_directory: t = "O_DIRECTORY"
  @module("node:fs") @scope("constants") external o_noatime: t = "O_NOATIME"
  @module("node:fs") @scope("constants") external o_nofollow: t = "O_NOFOLLOW"
  @module("node:fs") @scope("constants") external o_sync: t = "O_SYNC"
  @module("node:fs") @scope("constants") external o_dsync: t = "O_DSYNC"
  @module("node:fs") @scope("constants") external o_symlink: t = "O_SYMLINK"
  @module("node:fs") @scope("constants") external o_direct: t = "O_DIRECT"
  @module("node:fs") @scope("constants") external o_nonblock: t = "O_NONBLOCK"

  @@text("{1 File Type Constants}")

  @module("node:fs") @scope("constants") external s_ifmt: t = "S_IFMT"
  @module("node:fs") @scope("constants") external s_ifreg: t = "S_IFREG"
  @module("node:fs") @scope("constants") external s_ifdir: t = "S_IFDIR"
  @module("node:fs") @scope("constants") external s_ifchr: t = "S_IFCHR"
  @module("node:fs") @scope("constants") external s_ifblk: t = "S_IFBLK"
  @module("node:fs") @scope("constants") external s_ififo: t = "S_IFIFO"
  @module("node:fs") @scope("constants") external s_iflnk: t = "S_IFLNK"
  @module("node:fs") @scope("constants") external s_ifsock: t = "S_IFSOCK"

  @@text("{1 File Mode Constants}")

  @module("node:fs") @scope("constants") external s_irwxu: t = "S_IRWXU"
  @module("node:fs") @scope("constants") external s_irusr: t = "S_IRUSR"
  @module("node:fs") @scope("constants") external s_iwusr: t = "S_IWUSR"
  @module("node:fs") @scope("constants") external s_ixusr: t = "S_IXUSR"
  @module("node:fs") @scope("constants") external s_irwxg: t = "S_IRWXG"
  @module("node:fs") @scope("constants") external s_irgrp: t = "S_IRGRP"
  @module("node:fs") @scope("constants") external s_iwgrp: t = "S_IWGRP"
  @module("node:fs") @scope("constants") external s_ixgrp: t = "S_IXGRP"
  @module("node:fs") @scope("constants") external s_irwxo: t = "S_IRWXO"
  @module("node:fs") @scope("constants") external s_iroth: t = "S_IROTH"
  @module("node:fs") @scope("constants") external s_iwoth: t = "S_IWOTH"
  @module("node:fs") @scope("constants") external s_ixoth: t = "S_IXOTH"
}

module Flag: {
  type t = private string

  @inline("r")
  let read: t
  @inline("r+")
  let readWrite: t
  @inline("rs+")
  let readWriteSync: t
  @inline("w")
  let write: t
  @inline("wx")
  let writeFailIfExists: t
  @inline("w+")
  let writeRead: t
  @inline("wx+")
  let writeReadFailIfExists: t
  @inline("a")
  let append: t
  @inline("ax")
  let appendFailIfExists: t
  @inline("a+")
  let appendRead: t
  @inline("ax+")
  let appendReadFailIfExists: t
} = {
  type t = string
  @inline("r")
  let read = "r"
  @inline("r+")
  let readWrite = "r+"
  @inline("rs+")
  let readWriteSync = "rs+"
  @inline("w")
  let write = "w"
  @inline("wx")
  let writeFailIfExists = "wx"
  @inline("w+")
  let writeRead = "w+"
  @inline("wx+")
  let writeReadFailIfExists = "wx+"
  @inline("a")
  let append = "a"
  @inline("ax")
  let appendFailIfExists = "ax"
  @inline("a+")
  let appendRead = "a+"
  @inline("ax+")
  let appendReadFailIfExists = "ax+"
}

type fd = private int

type writeFileOptions = {
  mode?: int,
  flag?: Flag.t,
  encoding?: string,
}

type appendFileOptions = {
  mode?: int,
  flag?: Flag.t,
  encoding?: string,
}

@module("fs") external appendFileSync: (string, Buffer.t) => unit = "appendFileSync"
type readFileOptions = {
  flag?: Flag.t,
  encoding?: string,
}

type openFileOptions = {
  flag?: Flag.t,
  mode?: int,
}

type lstatSyncOptions = {
  bigint?: bool,
  throwIfNoEntry?: bool,
}

/**
 * `readdirSync(path)`
 * Reads the contents of a directory, returning an array of strings representing
 * the paths of files and sub-directories. **Execution is synchronous and blocking**.
 */
@module("node:fs")
external readdirSync: string => array<string> = "readdirSync"

/**
 * `renameSync(~oldPath, ~newPath)
 * Renames/moves the file located at `~oldPath` to `~newPath`. **Execution is
 * synchronous and blocking**.
 */
@module("node:fs")
external renameSync: (~from: string, ~to_: string) => unit = "renameSync"
@module("node:fs") external ftruncateSync: (fd, int) => unit = "ftruncateSync"
@module("node:fs")
external truncateSync: (string, int) => unit = "truncateSync"
@module("node:fs")
external chownSync: (string, ~uid: int, ~gid: int) => unit = "chownSync"
@module("node:fs")
external fchownSync: (fd, ~uid: int, ~gid: int) => unit = "fchownSync"
@module("node:fs") external readlinkSync: string => string = "readlinkSync"
@module("node:fs") external unlinkSync: string => unit = "unlinkSync"

/**
 * `rmdirSync(dirPath)
 * **Note: (recursive removal is experimental).**
 * Removes the directory at `dirPath`. **Execution is synchronous and blocking**.
 */
@module("node:fs")
external rmdirSync: string => unit = "rmdirSync"

@module("node:fs") external openSync: string => fd = "openSync"
@module("node:fs")
external openSyncWith: (string, ~flag: Flag.t=?, ~mode: int=?) => fd = "openSync"

@module("node:fs")
external readFileSync: string => Buffer.t = "readFileSync"
@module("node:fs")
external readFileSyncWith: (string, readFileOptions) => Buffer.t = "readFileSync"

@module("node:fs") external existsSync: string => bool = "existsSync"

@val @module("node:fs")
external writeFileSync: (string, Buffer.t) => unit = "writeFileSync"
@val @module("node:fs")
external writeFileSyncWith: (string, Buffer.t, writeFileOptions) => unit = "writeFileSync"

@val @module("node:fs")
external lstatSync: @unwrap [#String(string) | #Buffer(Buffer.t) | #Url(Url.t)] => Stats.t =
  "lstatSync"

@val @module("node:fs")
external lstatSyncWith: (
  @unwrap [#String(string) | #Buffer(Buffer.t) | #Url(Url.t)],
  lstatSyncOptions,
) => Stats.t = "lstatSync"

module FileHandle = {
  type t = {fd: fd}

  @send
  external appendFile: (t, Buffer.t, appendFileOptions) => Js.Promise.t<unit> = "appendFile"
  @send
  external appendFileWith: (t, Buffer.t) => Js.Promise.t<unit> = "appendFile"
  @send external chmod: (t, int) => Js.Promise.t<unit> = "chmod"
  @send external chown: (t, int, int) => Js.Promise.t<unit> = "chown"
  @send external close: t => Js.Promise.t<unit> = "close"
  @send external datasync: t => Js.Promise.t<unit> = "datasync"

  type readInfo = {
    bytesRead: int,
    buffer: Buffer.t,
  }

  @send
  external read: (
    t,
    Buffer.t,
    ~offset: int,
    ~length: int,
    ~position: int,
  ) => Js.Promise.t<readInfo> = "read"
  @send external readFile: t => Js.Promise.t<Buffer.t> = "readFile"
  @send
  external readFileWith: (t, readFileOptions) => Js.Promise.t<string> = "readFile"

  @send external stat: t => Js.Promise.t<Stats.t> = "stat"
  @send external sync: t => Js.Promise.t<unit> = "sync"
  @send
  external truncate: (t, ~length: int=?, unit) => Js.Promise.t<unit> = "truncate"

  type writeInfo = {bytesWritten: int}

  @send
  external write: (t, Buffer.t) => Js.Promise.t<writeInfo> = "write"
  @send
  external writeOffset: (t, Buffer.t, ~offset: int) => Js.Promise.t<writeInfo> = "write"
  @send
  external writeRange: (
    t,
    Buffer.t,
    ~offset: int,
    ~length: int,
    ~position: int,
  ) => Js.Promise.t<writeInfo> = "write"

  @send
  external writeFile: (t, Buffer.t) => Js.Promise.t<unit> = "writeFile"
  @send
  external writeFileWith: (t, Buffer.t, writeFileOptions) => Js.Promise.t<unit> = "writeFile"
}

module PromiseAPI = {
  @module("node:fs") @scope("promises")
  external access: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)] => Js.Promise.t<unit> =
    "access"
  @module("node:fs") @scope("promises")
  external accessWithMode: (
    @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
    ~mode: int,
  ) => Js.Promise.t<unit> = "access"

  type appendFileStrOptions = {
    encoding?: string,
    mode?: int,
    flag?: Flag.t,
  }
  @module("node:fs") @scope("promises")
  external appendFile: (
    ~path: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t) | #Handle(FileHandle.t)],
    ~data: string,
  ) => Js.Promise.t<unit> = "appendFile"

  @module("node:fs") @scope("promises")
  external appendFileWith: (
    ~path: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t) | #Handle(FileHandle.t)],
    ~data: string,
    ~options: appendFileStrOptions,
  ) => Js.Promise.t<unit> = "appendFile"

  type appendFileBufferOptions = {
    mode?: int,
    flag?: Flag.t,
  }
  @module("node:fs") @scope("promises")
  external appendFileBuffer: (
    ~path: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t) | #Handle(FileHandle.t)],
    ~data: Buffer.t,
  ) => Js.Promise.t<unit> = "appendFile"

  @module("node:fs") @scope("promises")
  external appendFileBufferWith: (
    ~path: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t) | #Handle(FileHandle.t)],
    ~data: Buffer.t,
    ~options: appendFileBufferOptions,
  ) => Js.Promise.t<unit> = "appendFile"

  @module("node:fs") @scope("promises")
  external chmod: (
    ~path: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
    ~mode: int,
  ) => Js.Promise.t<unit> = "chmod"

  @module("node:fs") @scope("promises")
  external chown: (
    ~path: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
    ~uid: int,
    ~gid: int,
  ) => Js.Promise.t<unit> = "chown"

  @module("node:fs") @scope("promises")
  external copyFile: (
    ~src: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
    ~dest: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
  ) => Js.Promise.t<unit> = "copyFile"

  @module("node:fs") @scope("promises")
  external copyFileFlag: (
    ~src: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
    ~dest: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
    ~flags: Constants.t,
  ) => Js.Promise.t<unit> = "copyFile"

  @module("node:fs") @scope("promises")
  external lchmod: (~path: @unwrap [#Str(string)], ~mode: int) => Js.Promise.t<unit> = "lchmod"

  @module("node:fs") @scope("promises")
  external link: (
    ~existingPath: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
    ~newPath: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
  ) => Js.Promise.t<unit> = "link"

  type statOptions = {bigint: int}
  @module("node:fs") @scope("promises")
  external lstat: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)] => Js.Promise.t<
    Stats.t,
  > = "lstat"

  @module("node:fs") @scope("promises")
  external lstatBigInt: (
    ~path: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
    ~options: statOptions,
  ) => Js.Promise.t<Stats.t> = "lstat"

  type mkdirOptions = {
    recursive?: bool,
    mode?: int,
  }

  @module("node:fs") @scope("promises")
  external mkdir: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)] => Js.Promise.t<unit> =
    "mkdir"

  @module("node:fs") @scope("promises")
  external mkdirWith: (
    @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
    mkdirOptions,
  ) => Js.Promise.t<unit> = "mkdir"

  type mkdtempOptions = {encoding?: string}

  @module("node:fs") @scope("promises")
  external mkdtemp: string => Js.Promise.t<string> = "mkdtemp"

  @module("node:fs") @scope("promises")
  external mkdtempWith: (
    ~prefix: string,
    ~mkdtempOptions: @unwrap [#Str(string) | #Option(mkdtempOptions)],
  ) => Js.Promise.t<string> = "mkddtemp"

  @module("node:fs") @scope("promises")
  external open_: (
    ~path: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
    ~flags: Flag.t,
  ) => Js.Promise.t<FileHandle.t> = "open"

  @module("node:fs") @scope("promises")
  external openWithMode: (
    ~path: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
    ~flags: Flag.t,
    ~mode: int,
  ) => Js.Promise.t<FileHandle.t> = "open"

  @module("node:fs") @scope("promises")
  external stat: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)] => Js.Promise.t<Stats.t> =
    "lstat"

  @module("node:fs") @scope("promises")
  external statWith: (
    ~path: @unwrap [#Str(string) | #Buffer(Buffer.t) | #URL(Url.t)],
    ~options: statOptions,
  ) => Js.Promise.t<Stats.t> = "lstat"
}

@module("node:fs") @scope("promises")
external access: string => Js.Promise.t<unit> = "access"
@module("fs") @scope("promises")
external accessWithMode: (string, ~mode: Constants.t) => Js.Promise.t<unit> = "access"

@module("node:fs") @scope("promises")
external appendFile: (string, string, appendFileOptions) => Js.Promise.t<unit> = "appendFile"

@module("node:fs") @scope("promises")
external appendFileWith: (string, string, appendFileOptions) => Js.Promise.t<unit> = "appendFile"

type appendFileBufferOptions = {mode?: int, flag?: Flag.t}

@module("node:fs") @scope("promises")
external appendFileBuffer: (string, Buffer.t) => Js.Promise.t<unit> = "appendFile"

@module("node:fs") @scope("promises")
external appendFileBufferWith: (string, Buffer.t, appendFileBufferOptions) => Js.Promise.t<unit> =
  "appendFile"

@module("node:fs") @scope("promises")
external chmod: (string, ~mode: int) => Js.Promise.t<unit> = "chmod"

@module("node:fs") @scope("promises")
external chown: (string, ~uid: int, ~gid: int) => Js.Promise.t<unit> = "chown"

@module("node:fs") @scope("promises")
external copyFile: (string, ~dest: string) => Js.Promise.t<unit> = "copyFile"

@module("node:fs") @scope("promises")
external copyFileFlag: (string, ~dest: string, ~flags: Constants.t) => Js.Promise.t<unit> =
  "copyFile"

@module("node:fs") @scope("promises")
external lchmod: (string, ~mode: int) => Js.Promise.t<unit> = "lchmod"

@module("node:fs") @scope("promises")
external link: (~existingPath: string, ~newPath: string) => Js.Promise.t<unit> = "link"

@module("node:fs") @scope("promises")
external lstat: string => Js.Promise.t<Stats.t> = "lstat"

@module("node:fs") @scope("promises")
external lstatBigInt: (string, bool) => Js.Promise.t<Stats.t> = "lstat"

type mkdirOptions = {recursive?: bool, mode?: int}

@module("node:fs") @scope("promises")
external mkdir: string => Js.Promise.t<unit> = "mkdir"

@module("node:fs") @scope("promises")
external mkdirWith: (string, mkdirOptions) => Js.Promise.t<unit> = "mkdir"

@module("node:fs")
external mkdirSync: string => unit = "mkdirSync"

@module("node:fs")
external mkdirSyncWith: (string, mkdirOptions) => unit = "mkdirSync"

type mkdtempOptions = {encoding?: string}

@module("node:fs") @scope("promises")
external mkdtemp: string => Js.Promise.t<string> = "mkddtemp"

@module("node:fs") @scope("promises")
external mkdtempWith: (string, mkdtempOptions) => Js.Promise.t<string> = "mkddtemp"

@module("node:fs") @scope("promises")
external open_: (string, Flag.t) => Js.Promise.t<FileHandle.t> = "open"

@module("node:fs") @scope("promises")
external openWithMode: (string, Flag.t, ~mode: int) => Js.Promise.t<FileHandle.t> = "open"

@module("fs") @scope("promises")
external readdir: string => Js.Promise.t<array<string>> = "readdir"

type readDirOptions
@obj
external readDirOptions: (~withFileTypes: bool, ~encoding: string=?, unit) => readDirOptions = ""

@module("fs") @scope("promises")
external _readdirWithFileTypes: (string, readDirOptions) => Js.Promise.t<array<Dirent.t>> =
  "readdir"
let readdirWithFileTypes = (dir: string) => {
  _readdirWithFileTypes(dir, readDirOptions(~withFileTypes=true, ()))
}

@module("fs") @scope("promises")
external readFile: (string, ~options: readFileOptions=?, unit) => Js.Promise.t<Buffer.t> =
  "readFile"

@module("fs") @scope("promises")
external unlink: string => Js.Promise.t<unit> = "unlink"

@module("fs") @scope("promises")
external writeFile: (string, Buffer.t, ~options: writeFileOptions=?, unit) => Js.Promise.t<unit> =
  "writeFile"

module WriteStream = {
  type kind<'w> = [Stream.writable<'w> | #FileSystem]
  type subtype<'w, 'ty> = Stream.subtype<[> kind<'w>] as 'ty>
  type supertype<'w, 'ty> = Stream.subtype<[< kind<'w>] as 'ty>
  type t = subtype<Buffer.t, [kind<Buffer.t>]>
  module Impl = {
    include Stream.Writable.Impl
    @send
    external bytesWritten: subtype<'w, [> kind<'w>]> => int = "bytesWritten"
    @send external path: subtype<'w, [> kind<'w>]> => string = "path"
    @send
    external pending: subtype<'w, [> kind<'w>]> => bool = "pending"
    @send
    external onOpen: (
      subtype<'w, [> kind<'w>]> as 'stream',
      @as("open") _,
      @uncurry fd => unit,
    ) => 'stream = "on"
    @send
    external onReady: (
      subtype<'w, [> kind<'w>]> as 'stream,
      @as("ready") _,
      @uncurry unit => unit,
    ) => 'stream = "on"
  }
  include Impl
}

module ReadStream = {
  type kind<'r> = [Stream.readable<'r> | #FileSystem]
  type subtype<'r, 'ty> = Stream.subtype<[> kind<'r>] as 'ty>
  type supertype<'r, 'ty> = Stream.subtype<[< kind<'r>] as 'ty>
  type t = subtype<Buffer.t, [kind<Buffer.t>]>
  module Impl = {
    include Stream.Readable.Impl
    @send
    external bytesRead: subtype<'r, [> kind<'r>]> => int = "bytesWritten"
    @send external path: subtype<'r, [> kind<'r>]> => string = "path"
    @send
    external pending: subtype<'r, [> kind<'r>]> => bool = "pending"
    @send
    external onOpen: (
      subtype<'r, [> kind<'r>]> as 'stream,
      @as("open") _,
      @uncurry fd => unit,
    ) => 'stream = "on"
    @send
    external onReady: (
      subtype<'r, [> kind<'r>]> as 'stream,
      @as("ready") _,
      @uncurry unit => unit,
    ) => 'stream = "on"
  }
  include Impl
}

type createReadStreamOptions = {
  flags?: Flag.t,
  encoding?: string,
  fd?: fd,
  mode?: int,
  autoClose?: bool,
  emitClose?: bool,
  start?: int,
  _end?: int,
  highWaterMark?: int,
}
@module("node:fs")
external createReadStream: string => ReadStream.t = "createReadStream"
@module("node:fs")
external createReadStreamWith: (string, createReadStreamOptions) => ReadStream.t =
  "createReadStream"

type createWriteStreamOptions<'fs> = {
  flags?: Flag.t,
  encoding?: string,
  fd?: fd,
  mode?: int,
  autoClose?: bool,
  emitClose?: bool,
  start?: int,
  fs?: 'fs,
}
@module("node:fs")
external createWriteStream: string => WriteStream.t = "createWriteStream"

@module("fs")
external createWriteStreamWith: (string, createWriteStreamOptions<'fs>) => WriteStream.t =
  "createWriteStream"
