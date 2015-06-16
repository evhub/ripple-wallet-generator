Q = require("q")
fs = require("fs")
temp = require("temp")
ripple = require("ripple-lib")
openssl = require("openssl-wrapper")

temp.track()

prefix = "ripple-wallet"

read_buffer = (none, buffer) ->
    console.log(buffer.toString())

encode_wallet = (encoded_file, prefix=prefix) ->
    wallet = ripple.Wallet.generate()
    tempfile = temp.openSync(prefix, "w")
    fs.write(tempfile.fd, JSON.stringify(wallet))
    openssl.qExec("enc", {"in": tempfile.path, "out": encoded_file, "aes-256-cbc": true})

decode_wallet = (encoded_file) ->
    openssl.exec("enc", {"d": true, "in": encoded_file, "aes-256-cbc": true}, read_buffer)

generate_cold_wallet = () ->
    console.log("Generating cold wallet...")
    encode_wallet("cold_wallet.enc")

generate_hot_wallet = () ->
    console.log("Generating hot wallet...")
    encode_wallet("hot_wallet.enc")

Q.fcall(generate_cold_wallet).then(generate_hot_wallet).then(() -> console.log("Wallets successfully generated."))
