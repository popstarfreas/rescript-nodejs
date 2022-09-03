open Zora

zoraBlock("Crypto", t => {
  t->block(
    "Hashing to sha256",
    t => {
        let input = "hash me"
        let hash = Crypto.createHash("sha256")
        ->Crypto.Hash.update(input->Buffer.fromString)
        ->Crypto.Hash.digestWithEncoding("hex")
        t->equal("eb201af5aaf0d60629d3d2a61e466cfc0fedb517add831ecac5235e1daa963d6", hash, "")
    },
  )
  t->block(
    "Hashing with key to sha256",
    t => {
        let input = "hash me"
        let hash = Crypto.createHmac("sha256", ~key="secret")
        ->Crypto.Hmac.update(input->Buffer.fromString)
        ->Crypto.Hmac.digestWithEncoding("hex")
        t->equal("832324d67f36f13c0ab0730000d4aaf469ff0983edcf170a9fdcaa22f6672fec", hash, "")
    },
  )
})
