open Zora

let nodeProcess = Process.process

zoraBlock("Process", t => {
  t->block("Should allow attaching on SIGINT", t => {
    nodeProcess->Process.onSigInt(_signal => ())->ignore
    t->ok(true, "Should have not raised exception")
  })

  t->block("Should expose pid, ppid, and cwd", t => {
    t->ok(Process.pid(nodeProcess) > 0, "")
    t->ok(Process.ppid(nodeProcess) > 0, "")
    t->notEqual(Process.cwd(nodeProcess), "", "")
    t->notEqual(Process.platform(nodeProcess), "", "")
  })

  t->block("Should provide argv and execution metadata", t => {
    t->ok(Process.argv(nodeProcess)->Array.length >= 1, "")
    t->notEqual(Process.argv0(nodeProcess), "", "")
    t->notEqual(Process.execPath(nodeProcess), "", "")
  })

  t->block("Should expose environment and version details", t => {
    let env = Process.env(nodeProcess)
    let pathVar =
      switch Dict.get(env, "PATH") {
      | None => Dict.get(env, "Path")
      | Some(value) => Some(value)
      }

    t->equal(pathVar->Option.isSome, true, "")
    t->equal(Dict.get(Process.versions(nodeProcess), "node")->Option.isSome, true, "")
  })

  t->block("Should report memory usage and uptime", t => {
    let usage = Process.memoryUsage(nodeProcess)
    t->ok(usage.rss >= 0, "")
    t->ok(usage.heapTotal >= 0, "")
    t->ok(usage.heapUsed >= 0, "")
    t->ok(Process.uptime(nodeProcess) >= 0., "")
  })

  t->block("Should expose high resolution timers", t => {
    let (seconds, nanoseconds) = Process.hrtime(nodeProcess)
    t->ok(seconds >= 0, "")
    t->ok(nanoseconds >= 0, "")
    t->equal(Process.hrtimeBigInt(nodeProcess)->typeof, #bigint, "")
  })

  t->block("Should expose stdio streams", t => {
    t->notEqual(Nullable.make(Process.stdout(nodeProcess)), Nullable.undefined, "")
    t->notEqual(Nullable.make(Process.stderr(nodeProcess)), Nullable.undefined, "")
    t->notEqual(Nullable.make(Process.stdin(nodeProcess)), Nullable.undefined, "")
  })

  t->test("nextTick should schedule callbacks with arguments", t =>
    Promise.make((resolve, _) => {
      nodeProcess->Process.nextTickApply3(
        (one, two, three) => {
          t->equal((one, two, three), ("one", 2, true), "")
          resolve()
        },
        "one",
        2,
        true,
      )
    })
  )
})
