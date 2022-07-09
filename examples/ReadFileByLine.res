open NodeJs

// example from the NodeJS docs
let rl = Readline.make(
  Readline.interfaceOptions(~input=Fs.createReadStream("sample.txt"), ~crlfDelay=infinity, ()),
)

rl
->Readline.Interface.on(Event.fromString("line"), line => {
  Js.log(`Received: ${line}`)
})
->ignore
