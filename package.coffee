fs = require("fs")

packobj =
    name: "ripple-wallet-generator"
    version: "0.1.0"
    description: "Generates and encrypts Ripple Wallets."
    repository: "evhub/ripple-wallet-generator"
    files: ["WalletMaker.js"]
    dependencies:
        "openssl-wrapper": "0.2.1"
        "q": "1.4.1"
        "ripple-lib": "*"
        "temp": "0.8.3"

packjson = JSON.stringify(packobj)
packfile = fs.openSync("package.json", "w")
fs.write(packfile, packjson)
