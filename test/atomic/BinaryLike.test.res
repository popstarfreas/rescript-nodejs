open Zora
zoraBlock("BinaryLike", t => {
  open Js.TypedArray2
  let uint8FromArray: array<int> => Uint8Array.t = %raw(`arr => new Uint8Array(arr)`)
  let int8FromArray: array<int> => Int8Array.t = %raw(`arr => new Int8Array(arr)`)
  let uint8ClampedFromArray: array<int> => Uint8ClampedArray.t =
    %raw(`arr => new Uint8ClampedArray(arr)`)
  let uint16FromArray: array<int> => Uint16Array.t = %raw(`arr => new Uint16Array(arr)`)
  let int16FromArray: array<int> => Int16Array.t = %raw(`arr => new Int16Array(arr)`)

  let string_ = "test1234"
  let binaryLikeString = string_->BinaryLike.string

  let buffer_ = Buffer.fromArray([1, 2, 3, 4])
  let binaryLikeBuffer = BinaryLike.buffer(buffer_)

  let uInt8Array = uint8FromArray([1, 2, 3, 4])
  let binaryLikeUint8Array = BinaryLike.uInt8Array(uInt8Array)

  let int8Array = int8FromArray([1, 2, 3, 4])
  let binaryLikeInt8Array = BinaryLike.int8Array(int8Array)

  let uInt8ClampedArray = uint8ClampedFromArray([1, 2, 3, 4])
  let binaryLikeUint8ClampedArray = BinaryLike.uInt8ClampedArray(uInt8ClampedArray)

  let uInt16Array = uint16FromArray([1, 2, 3, 4])
  let binaryLikeUint16Array = BinaryLike.uInt16Array(uInt16Array)

  let int16Array = int16FromArray([1, 2, 3, 4])
  let binaryLikeInt16Array = BinaryLike.int16Array(int16Array)

  t->block("BinaryLike.classify(string) should return a 'String' variant", t => {
    t->ok(
      switch BinaryLike.classify(binaryLikeString) {
      | String(_) => true
      | _ => false
      },
      "",
    )
  })

  t->block("BinaryLike.classify(buffer) should return a 'Buffer' variant", t => {
    t->ok(
      switch BinaryLike.classify(binaryLikeBuffer) {
      | Buffer(_) => true
      | _ => false
      },
      "",
    )
  })

  t->block("BinaryLike.classify(uInt8Array) should return a 'Uint8Array' variant", t => {
    t->ok(
      switch BinaryLike.classify(binaryLikeUint8Array) {
      | Uint8Array(_) => true
      | _ => false
      },
      "",
    )
  })

  t->block("BinaryLike.classify(int8Array) should return a 'Int8Array' variant", t => {
    t->ok(
      switch BinaryLike.classify(binaryLikeInt8Array) {
      | Int8Array(_) => true
      | _ => false
      },
      "",
    )
  })

  t->block(
    "BinaryLike.classify(uInt8ClampedArray) should return a 'Uint8ClampedArray' variant",
    t => {
      t->ok(
        switch BinaryLike.classify(binaryLikeUint8ClampedArray) {
        | Uint8ClampedArray(_) => true
        | _ => false
        },
        "",
      )
    },
  )

  t->block("BinaryLike.classify(uInt16Array) should return a 'Uint16Array' variant", t => {
    t->ok(
      switch BinaryLike.classify(binaryLikeUint16Array) {
      | Uint16Array(_) => true
      | _ => false
      },
      "",
    )
  })

  t->block("BinaryLike.classify(int16Array) should return a 'Int16Array' variant", t => {
    t->ok(
      switch BinaryLike.classify(binaryLikeInt16Array) {
      | Int16Array(_) => true
      | _ => false
      },
      "",
    )
  })
})
