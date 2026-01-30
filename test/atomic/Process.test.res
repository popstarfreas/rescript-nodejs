open Zora

let process_ = Process.process

zoraBlock("Process", t => {
  t->block("Should allow attaching on SIGINT", t => {
    process_->Process.onSigInt(_signal => ())->ignore
    t->ok(true, "Should have not raised exception")
  })

  t->block("Should expose pid, ppid, and cwd", t => {
    t->ok(Process.pid(process_) > 0, "")
    t->ok(Process.ppid(process_) > 0, "")
    t->notEqual(Process.cwd(process_), "", "")
    t->notEqual(Process.platform(process_), "", "")
  })

  t->block("Should provide argv and execution metadata", t => {
    t->ok(Process.argv(process_)->Array.length >= 1, "")
    t->notEqual(Process.argv0(process_), "", "")
    t->notEqual(Process.execPath(process_), "", "")
  })

  t->block("Should expose environment and version details", t => {
    let env = Process.env(process_)
    let pathVar = switch Dict.get(env, "PATH") {
    | None => Dict.get(env, "Path")
    | Some(value) => Some(value)
    }

    t->equal(pathVar->Option.isSome, true, "")
    t->equal(Dict.get(Process.versions(process_), "node")->Option.isSome, true, "")
  })

  t->block("Should report memory usage and uptime", t => {
    let usage = Process.memoryUsage(process_)
    t->ok(usage.rss >= 0, "")
    t->ok(usage.heapTotal >= 0, "")
    t->ok(usage.heapUsed >= 0, "")
    t->ok(Process.uptime(process_) >= 0., "")
  })

  t->block("Should expose high resolution timers", t => {
    let (seconds, nanoseconds) = Process.hrtime(process_)
    t->ok(seconds >= 0, "")
    t->ok(nanoseconds >= 0, "")
    t->equal(Process.hrtimeBigInt(process_)->typeof, #bigint, "")
  })

  t->block("Should expose stdio streams", t => {
    t->notEqual(Nullable.make(Process.stdout(process_)), Nullable.undefined, "")
    t->notEqual(Nullable.make(Process.stderr(process_)), Nullable.undefined, "")
    t->notEqual(Nullable.make(Process.stdin(process_)), Nullable.undefined, "")
  })

  t->test("nextTick should schedule callbacks with arguments", t =>
    Promise.make(
      (resolve, _) => {
        process_->Process.nextTickApply3(
          (one, two, three) => {
            t->equal((one, two, three), ("one", 2, true), "")
            resolve()
          },
          "one",
          2,
          true,
        )
      },
    )
  )

  t->block("Local import should not cause error", t => {
    let {process} = module(NodeJs.Process)
    Stdlib.Console.log(process->Process.argv0)
    t->ok(true, "")
  })
})
