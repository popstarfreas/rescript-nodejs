open Zora

zoraBlock("Global", t => {
  t->block("dirname should be defined", t =>
    t->notEqual(Nullable.make(Global.dirname(Global.importMetaUrl)), Nullable.undefined, "")
  )
  t->block("dirname should be of type 'string'", t =>
    t->equal(Global.dirname(Global.importMetaUrl)->typeof, #string, "")
  )

  t->block("filename should be defined", t =>
    t->notEqual(Nullable.make(Global.filename(Global.importMetaUrl)), Nullable.undefined, "")
  )
  t->block("filename should be of type 'string'", t =>
    t->equal(Global.filename(Global.importMetaUrl)->typeof, #string, "")
  )

  t->block("'global object' should be defined", t =>
    t->notEqual(Nullable.make(Global.global), Nullable.undefined, "")
  )
  t->block("'global' object should be of type 'object'", t =>
    t->equal(Global.global->typeof, #object, "")
  )

  t->block("'import' function should be defined", t =>
    t->notEqual(Nullable.make(Global.import), Nullable.undefined, "")
  )
  t->block("'import' function should be of type 'function'", t =>
    t->equal(Global.import->typeof, #function, "")
  )

  t->test("'import' fuction should return a defined value from a relative path", async t =>
    t->notEqual(Nullable.make(await Global.import("path")), Nullable.undefined, "")
  )
  t->test(
    "'import' fuction should successfully import a module object from a relative path",
    async t => {
      t->equal((await Global.import("path"))->typeof, #object, "")
    },
  )
})
