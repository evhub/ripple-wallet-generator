Q = require("q")
fs = require("fs")
temp = require("temp")
ripple = require("ripple-lib")
openssl = require("openssl-wrapper")

temp.track()

prefix = "ripple-wallet"
encoded_file = "encoded_wallet.json"

wallet = ripple.Wallet.generate()

tempfile = temp.openSync(prefix, "w")
fs.write(tempfile.fd, JSON.stringify(wallet))

read_buffer = (none, buffer) ->
    console.log(buffer.toString())

openssl.qExec("enc", {"in": tempfile.path, "out": encoded_file, "aes-256-cbc": true})
.then(() -> openssl.exec("enc", {"d": true, "in": encoded_file, "aes-256-cbc": true}, read_buffer))
