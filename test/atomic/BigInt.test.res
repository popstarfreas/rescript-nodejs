open Zora

zoraBlock("BigInt", t => {
  let randomIntF = max => {
    Math.floor(Math.random() * Int.toFloat(max))
  }

  t->block(
    "'BigInt.fromInt' and 'BigInt.toInt' are associative operations for all 32-bit integers",
    t => {
      let arrA = Array.fromInitializer(~length=1000, _ => randomIntF(1000000))
      let arrB = Array.map(arrA, BigInt.fromFloat)
      let arrC = Array.map(arrB, i => BigInt.toInt(i)->Float.fromInt)
      t->equal(arrA, arrC, "")
    },
  )

  t->block("BigInt.add", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = a + b

    open BigInt
    t->equal(add(fromFloat(a), fromFloat(b)), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.(+)", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = a + b

    open! BigInt
    t->equal(fromFloat(a) + fromFloat(b), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.subtract", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = a - b

    open BigInt
    t->equal(subtract(fromFloat(a), fromFloat(b)), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.(-)", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = a - b

    open! BigInt
    t->equal(fromFloat(a) - fromFloat(b), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.multiply", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = a * b

    open BigInt
    t->equal(multiply(fromFloat(a), fromFloat(b)), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.(*)", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = a * b

    open! BigInt
    t->equal(fromFloat(a) * fromFloat(b), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.divide", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = Math.floor(a / b)

    open BigInt
    t->equal(divide(fromFloat(a), fromFloat(b)), fromFloat(c), "")
  })

  t->block("BigInt.(/)", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = Math.floor(a / b)

    open! BigInt
    t->equal(fromFloat(a) / fromFloat(b), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.negate", t => {
    let a = randomIntF(10000)
    let b = -a

    open BigInt
    t->equal(negate(fromFloat(a)), fromFloat(b), "")
  })

  t->block("BigInt.(~-)", t => {
    let a = randomIntF(10000)
    let b = -a

    open! BigInt
    t->equal(-fromFloat(a), BigInt.fromFloat(b), "")
  })

  t->block("BigInt.modulo", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = mod(a, b)

    open BigInt
    t->equal(modulo(fromFloat(a), fromFloat(b)), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.(mod)", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = mod(a, b)

    open! BigInt
    t->equal(mod(fromFloat(a), fromFloat(b)), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.power", t => {
    let a = randomIntF(6)
    let b = randomIntF(8)

    let c = Math.pow(a, ~exp=b)

    open BigInt
    t->equal(power(fromFloat(a), fromFloat(b)), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.(**)", t => {
    let a = randomIntF(6)
    let b = randomIntF(8)

    @ocaml.warning("-3")
    let c = Math.pow(a, ~exp=b)

    open! BigInt
    t->equal(fromFloat(a) ** fromFloat(b), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.logicalAnd", t => {
    let a = randomIntF(256)
    let b = randomIntF(256)
    let c = Float.toInt(a) &&& Float.toInt(b)

    open BigInt
    t->equal(logicalAnd(fromFloat(a), fromFloat(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(land)", t => {
    let a = randomIntF(256)
    let b = randomIntF(256)
    let c = Float.toInt(a) &&& Float.toInt(b)

    open! BigInt
    t->equal(land(fromFloat(a), fromFloat(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.logicalOr", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = Float.toInt(a) ||| Float.toInt(b)

    open BigInt
    t->equal(logicalOr(fromFloat(a), fromFloat(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(lor)", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = Float.toInt(a) ||| Float.toInt(b)

    open! BigInt
    t->equal(lor(fromFloat(a), fromFloat(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.logicalXor", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = Float.toInt(a) ^^^ Float.toInt(b)

    open BigInt
    t->equal(logicalXor(fromFloat(a), fromFloat(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(lxor)", t => {
    let a = randomIntF(10000)
    let b = randomIntF(10000)
    let c = Float.toInt(a) ^^^ Float.toInt(b)

    open! BigInt
    t->equal(lxor(fromFloat(a), fromFloat(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.logicalNot", t => {
    let a = randomIntF(10000)
    let b = ~~~Float.toInt(a)

    open BigInt
    t->equal(logicalNot(fromFloat(a)), BigInt.fromInt(b), "")
  })

  t->block("BigInt.(lnot)", t => {
    let a = randomIntF(10000)
    let b = ~~~Float.toInt(a)

    open! BigInt
    t->equal(lnot(fromFloat(a)), BigInt.fromInt(b), "")
  })

  t->block("BigInt.logicalShiftLeft", t => {
    let a = 26
    let b = 7
    let c = a << b

    open BigInt
    t->equal(logicalShiftLeft(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(lsl)", t => {
    let a = 26
    let b = 7
    let c = a << b

    open! BigInt
    t->equal(lsl(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.arithmeticShiftRight", t => {
    let a = 32
    let b = 4
    let c = a >> b

    open BigInt
    t->equal(arithmeticShiftRight(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(asr)", t => {
    let a = 32
    let b = 4
    let c = a >> b

    open! BigInt
    t->equal(asr(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })
})
