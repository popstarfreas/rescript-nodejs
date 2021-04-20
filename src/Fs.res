module Dirent = {
  type t
  @send external isBlockDevice: t => bool = "isBlockDevice"
  @send external isCharacterDevice: t => bool = "isCharacterDevice"
  @send external isDirectory: t => bool = "isDirectory"
  @send external isFIFO: t => bool = "isFIFO"
  @send external isFile: t => bool = "isFile"
  @send external isSocket: t => bool = "isSocket"
  @send external isSymbolicLink: t => bool = "isSymbolicLink"
  @get external name: t => string = "name"
}

module Dir = {
  type t
  @send external close: t => Js.Promise.t<unit> = "close"
  @send
  external closeWithCallback: (t, Js.nullable<Js.Exn.t> => unit) => unit = "close"
  @send external closeSync: t => unit = "closeSync"
  @get external path: t => string = "path"
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

  @ocaml.doc(" `isFile(stats)` Returns true if the `stats` object describes a file. ") @send
  external isFile: t => bool = "isFile"
  @ocaml.doc(" `isDirectory(stats)` Returns true if the `stats` object describes a directory. ")
  @send
  external isDirectory: t => bool = "isDirectory"
  @ocaml.doc(
    " `isBlockDevice(stats)` Returns true if the `stats` object describes a block device. "
  )
  @send
  external isBlockDevice: t => bool = "isBlockDevice"
  @ocaml.doc(
    " `isBlockDevice(stats)` Returns true if the `stats` object describes a character device. "
  )
  @send
  external isCharacterDevice: t => bool = "isCharacterDevice"
  @ocaml.doc(
    " `isBlockDevice(stats)` Returns true if the `stats` object describes a symbolic link. "
  )
  @send
  external isSymbolicLink: t => bool = "isSymbolicLink"
  @ocaml.doc(
    " `isBlockDevice(stats)` Returns true if the `stats` object describes a first-in-first-out (FIFO) pipe. "
  )
  @send
  external isFIFO: t => bool = "isFIFO"
  @ocaml.doc(" `isBlockDevice(stats)` Returns true if the `stats` object describes a socket. ")
  @send
  external isSocket: t => bool = "isSocket"
}

module Constants = {
  type t = private int

  @ocaml.doc(" Bitwise 'or' i.e. JavaScript [x | y] ")
  external lor: (t, t) => t = "%orint"

  @@text("{1 File Access Constants}")

  @module("fs") @scope("constants") external f_ok: t = "F_OK"
  @module("fs") @scope("constants") external w_ok: t = "W_OK"
  @module("fs") @scope("constants") external r_ok: t = "R_OK"
  @module("fs") @scope("constants") external x_ok: t = "X_OK"

  @@text("{1 File Copy Constants}")

  @module("fs") @scope("constants") external copyfile_excl: t = "COPYFILE_EXCL"
  @module("fs") @scope("constants") external copyfile_ficlone: t = "COPYFILE_FICLONE"
  @module("fs") @scope("constants") external copyfile_ficlone_force: t = "COPYFILE_FICLONE_FORCE"

  @@text("{1 File Open Constants}")

  @module("fs") @scope("constants") external o_rdonly: t = "O_RDONLY"
  @module("fs") @scope("constants") external o_wronly: t = "O_WRONLY"
  @module("fs") @scope("constants") external o_rdwr: t = "O_RDWR"
  @module("fs") @scope("constants") external o_creat: t = "O_CREAT"
  @module("fs") @scope("constants") external o_excl: t = "O_EXCL"
  @module("fs") @scope("constants") external o_noctty: t = "O_NOCTTY"
  @module("fs") @scope("constants") external o_trunc: t = "O_TRUNC"
  @module("fs") @scope("constants") external o_append: t = "O_APPEND"
  @module("fs") @scope("constants") external o_directory: t = "O_DIRECTORY"
  @module("fs") @scope("constants") external o_noatime: t = "O_NOATIME"
  @module("fs") @scope("constants") external o_nofollow: t = "O_NOFOLLOW"
  @module("fs") @scope("constants") external o_sync: t = "O_SYNC"
  @module("fs") @scope("constants") external o_dsync: t = "O_DSYNC"
  @module("fs") @scope("constants") external o_symlink: t = "O_SYMLINK"
  @module("fs") @scope("constants") external o_direct: t = "O_DIRECT"
  @module("fs") @scope("constants") external o_nonblock: t = "O_NONBLOCK"

  @@text("{1 File Type Constants}")

  @module("fs") @scope("constants") external s_ifmt: t = "S_IFMT"
  @module("fs") @scope("constants") external s_ifreg: t = "S_IFREG"
  @module("fs") @scope("constants") external s_ifdir: t = "S_IFDIR"
  @module("fs") @scope("constants") external s_ifchr: t = "S_IFCHR"
  @module("fs") @scope("constants") external s_ifblk: t = "S_IFBLK"
  @module("fs") @scope("constants") external s_ififo: t = "S_IFIFO"
  @module("fs") @scope("constants") external s_iflnk: t = "S_IFLNK"
  @module("fs") @scope("constants") external s_ifsock: t = "S_IFSOCK"

  @@text("{1 File Mode Constants}")

  @module("fs") @scope("constants") external s_irwxu: t = "S_IRWXU"
  @module("fs") @scope("constants") external s_irusr: t = "S_IRUSR"
  @module("fs") @scope("constants") external s_iwusr: t = "S_IWUSR"
  @module("fs") @scope("constants") external s_ixusr: t = "S_IXUSR"
  @module("fs") @scope("constants") external s_irwxg: t = "S_IRWXG"
  @module("fs") @scope("constants") external s_irgrp: t = "S_IRGRP"
  @module("fs") @scope("constants") external s_iwgrp: t = "S_IWGRP"
  @module("fs") @scope("constants") external s_ixgrp: t = "S_IXGRP"
  @module("fs") @scope("constants") external s_irwxo: t = "S_IRWXO"
  @module("fs") @scope("constants") external s_iroth: t = "S_IROTH"
  @module("fs") @scope("constants") external s_iwoth: t = "S_IWOTH"
  @module("fs") @scope("constants") external s_ixoth: t = "S_IXOTH"
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

type writeFileOptions
@obj
external writeFileOptions: (~mode: int=?, ~flag: string=?, unit) => writeFileOptions = ""

type appendFileOptions
@obj
external appendFileOptions: (~mode: int=?, ~flag: Flag.t=?, unit) => appendFileOptions = ""

type readFileOptions
@obj external readFileOptions: (~flag: Flag.t=?, unit) => readFileOptions = ""

@ocaml.doc("
 * `readdirSync(path)`
 * Reads the contents of a directory, returning an array of strings representing
 * the paths of files and sub-directories. **Execution is synchronous and blocking**.
 ")
@module("fs")
external readdirSync: string => array<string> = "readdirSync"

@ocaml.doc("
 * `renameSync(~oldPath, ~newPath)
 * Renames/moves the file located at `~oldPath` to `~newPath`. **Execution is
 * synchronous and blocking**.
 ")
@module("fs")
external renameSync: (~from: string, ~to_: string) => unit = "renameSync"
@module("fs") external ftruncateSync: (fd, int) => unit = "ftruncateSync"
@module("fs")
external truncateSync: (string, int) => unit = "truncateSync"
@module("fs")
external chownSync: (string, ~uid: int, ~gid: int) => unit = "chownSync"
@module("fs")
external fchownSync: (fd, ~uid: int, ~gid: int) => unit = "fchownSync"
@module("fs") external readlinkSync: string => string = "readlinkSync"
@module("fs") external unlinkSync: string => unit = "unlinkSync"

@ocaml.doc("
 * `rmdirSync(dirPath)
 * **Note: (recursive removal is experimental).**
 * Removes the directory at `dirPath`. **Execution is synchronous and blocking**.
 ")
@module("fs")
external rmdirSync: string => unit = "rmdirSync"

@module("fs") external openSync: string => fd = "openSync"
@module("fs")
external openSyncWith: (string, ~flag: Flag.t=?, ~mode: int=?) => fd = "openSync"

@module("fs")
external readFileSync: (string, ~options: readFileOptions=?, unit) => Buffer.t = "readFileSync"
@module("fs") external existsSync: string => bool = "existsSync"

type writeFileSyncOptions
@obj
external writeFileSyncOptions: (~mode: int=?, ~flag: Flag.t=?, unit) => writeFileSyncOptions = ""

@val @module("fs")
external writeFileSync: (string, Buffer.t) => unit = "writeFileSync"
@val @module("fs")
external writeFileSyncWith: (string, Buffer.t, writeFileSyncOptions) => unit = "writeFileSync"

module FileHandle = {
  type t

  @send
  external appendFile: (t, Buffer.t, appendFileOptions) => Js.Promise.t<unit> = "appendFile"
  @send
  external appendFileWith: (t, Buffer.t) => Js.Promise.t<unit> = "appendFile"
  @send external chmod: (t, int) => Js.Promise.t<unit> = "chmod"
  @send external chown: (t, int, int) => Js.Promise.t<unit> = "chown"
  @send external close: t => Js.Promise.t<unit> = "close"
  @send external datasync: t => Js.Promise.t<unit> = "datasync"
  @get external fd: t => fd = "fd"

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
  external readFileWith: (t, ~encoding: string) => Js.Promise.t<string> = "readFile"

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

  type writeFileOptions
  @obj
  external writeFileOptions: (~mode: int=?, ~flag: Flag.t=?, unit) => writeFileOptions = ""

  @send
  external writeFile: (t, Buffer.t) => Js.Promise.t<unit> = "writeFile"
  @send
  external writeFileWith: (t, Buffer.t, writeFileOptions) => Js.Promise.t<unit> = "writeFile"
}

@module("fs") @scope("promises")
external access: string => Js.Promise.t<unit> = "access"
@module("fs") @scope("promises")
external accessWithMode: (string, ~mode: int) => Js.Promise.t<unit> = "access"

@module("fs") @scope("promises")
external appendFile: (string, string, appendFileOptions) => Js.Promise.t<unit> = "appendFile"

@module("fs") @scope("promises")
external appendFileWith: (string, string, appendFileOptions) => Js.Promise.t<unit> = "appendFile"

type appendFileBufferOptions
@obj
external appendFileBufferOptions: (~mode: int=?, ~flag: Flag.t=?, unit) => appendFileBufferOptions =
  ""

@module("fs") @scope("promises")
external appendFileBuffer: (string, Buffer.t) => Js.Promise.t<unit> = "appendFile"

@module("fs") @scope("promises")
external appendFileBufferWith: (string, Buffer.t, appendFileBufferOptions) => Js.Promise.t<unit> =
  "appendFile"

@module("fs") @scope("promises")
external chmod: (string, ~mode: int) => Js.Promise.t<unit> = "chmod"

@module("fs") @scope("promises")
external chown: (string, ~uid: int, ~gid: int) => Js.Promise.t<unit> = "chown"

@module("fs") @scope("promises")
external copyFile: (string, ~dest: string) => Js.Promise.t<unit> = "copyFile"

@module("fs") @scope("promises")
external copyFileFlag: (string, ~dest: string, ~flags: Constants.t) => Js.Promise.t<unit> =
  "copyFile"

@module("fs") @scope("promises")
external lchmod: (string, ~mode: int) => Js.Promise.t<unit> = "lchmod"

@module("fs") @scope("promises")
external link: (~existingPath: string, ~newPath: string) => Js.Promise.t<unit> = "link"

@module("fs") @scope("promises")
external lstat: string => Js.Promise.t<Stats.t> = "lstat"

@module("fs") @scope("promises")
external lstatBigInt: (string, bool) => Js.Promise.t<Stats.t> = "lstat"

type mkdirOptions
@obj
external mkdirOptions: (~recursive: bool=?, ~mode: int=?, unit) => mkdirOptions = ""

@module("fs") @scope("promises")
external mkdir: (string, mkdirOptions) => Js.Promise.t<unit> = "mkdir"

@module("fs") @scope("promises")
external mkdirWith: (string, mkdirOptions) => Js.Promise.t<unit> = "mkdir"

type mkdtempOptions
@obj external mdktempOptions: unit => mkdtempOptions = ""

@module("fs") @scope("promises")
external mkdtemp: (string, mkdtempOptions) => Js.Promise.t<string> = "mkddtemp"

@module("fs") @scope("promises")
external mkdtempWith: (string, mkdtempOptions) => Js.Promise.t<string> = "mkddtemp"

@module("fs") @scope("promises")
external open_: (string, Flag.t) => Js.Promise.t<FileHandle.t> = "open"

@module("fs") @scope("promises")
external openWithMode: (string, Flag.t, ~mode: int) => Js.Promise.t<FileHandle.t> = "open"

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
      @uncurry (fd => unit),
    ) => 'stream = "on"
    @send
    external onReady: (
      subtype<'w, [> kind<'w>]> as 'stream,
      @as("ready") _,
      @uncurry (unit => unit),
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
      @uncurry (fd => unit),
    ) => 'stream = "on"
    @send
    external onReady: (
      subtype<'r, [> kind<'r>]> as 'stream,
      @as("ready") _,
      @uncurry (unit => unit),
    ) => 'stream = "on"
  }
  include Impl
}

type createReadStreamOptions
@obj
external createReadStreamOptions: (
  ~flags: string=?,
  ~fd: fd=?,
  ~mode: int=?,
  ~autoClose: bool=?,
  ~emitClose: bool=?,
  ~start: int=?,
  ~_end: int=?,
  ~highWaterMark: int=?,
  unit,
) => createReadStreamOptions = ""

@module("fs")
external createReadStream: string => ReadStream.t = "createReadStream"
@module("fs")
external createReadStreamWith: (string, createReadStreamOptions) => ReadStream.t =
  "createReadStream"

type createWriteStreamOptions
@obj
external createWriteStreamOptions: (
  ~flags: string=?,
  ~fd: fd=?,
  ~mode: int=?,
  ~autoClose: bool=?,
  ~emitClose: bool=?,
  ~start: int=?,
  ~fs: {..}=?,
  unit,
) => createReadStreamOptions = ""
@module("fs")
external createWriteStream: string => WriteStream.t = "createWriteStream"

@module("fs")
external createWriteStreamWith: (string, createWriteStreamOptions) => WriteStream.t =
  "createWriteStream"
