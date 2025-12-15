open Zora
let nodeProcess = Process.process

zoraBlock("Console", t => {
  let c1 = {
    open Console
    make({
      stderr: Process.stderr(nodeProcess),
      ignoreErrors: false,
      colorMode: true,
      inspectOptions: {},
      stdout: Process.stdout(nodeProcess),
    })
  }

  let c2 = Console.make2({
    "stderr": Process.stderr(nodeProcess),
    "ignoreErrors": false,
    "colorMode": true,
    "stdout": Process.stdout(nodeProcess),
  })

  Stdlib.Console.log("=== Testing console output styles ===")
  c1->Console.logMany(["a", "b"])
  c2->Console.table(["hi", "bye"])
  c2->Console.table([
    {
      "a": 1,
      "b": 2,
    },
  ])
  Stdlib.Console.log({
    "hello": "world",
    "this": "is",
    "an": "object",
  })
  Stdlib.Console.log("=== END testing console output styles ===")

  t->block("New console instance should be defined", t =>
    t->notEqual(Nullable.make(c1), Nullable.undefined, "")
  )
  t->block("New console instance should be defined", t =>
    t->notEqual(Nullable.make(c2), Nullable.undefined, "")
  )
})
