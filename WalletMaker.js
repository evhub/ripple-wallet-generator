// Generated by CoffeeScript 1.9.3
(function() {
  var Q, decode_wallet, encode_wallet, fs, generate_cold_wallet, generate_hot_wallet, openssl, prefix, read_buffer, ripple, temp;

  Q = require("q");

  fs = require("fs");

  temp = require("temp");

  ripple = require("ripple-lib");

  openssl = require("openssl-wrapper");

  temp.track();

  prefix = "ripple-wallet";

  read_buffer = function(none, buffer) {
    return console.log(buffer.toString());
  };

  encode_wallet = function(encoded_file, prefix) {
    var tempfile, wallet;
    if (prefix == null) {
      prefix = prefix;
    }
    wallet = ripple.Wallet.generate();
    tempfile = temp.openSync(prefix, "w");
    fs.write(tempfile.fd, JSON.stringify(wallet));
    return openssl.qExec("enc", {
      "in": tempfile.path,
      "out": encoded_file,
      "aes-256-cbc": true
    });
  };

  decode_wallet = function(encoded_file) {
    return openssl.exec("enc", {
      "d": true,
      "in": encoded_file,
      "aes-256-cbc": true
    }, read_buffer);
  };

  generate_cold_wallet = function() {
    console.log("Generating cold wallet...");
    return encode_wallet("cold_wallet.enc");
  };

  generate_hot_wallet = function() {
    console.log("Generating hot wallet...");
    return encode_wallet("hot_wallet.enc");
  };

  Q.fcall(generate_cold_wallet).then(generate_hot_wallet).then(function() {
    return console.log("Wallets successfully generated.");
  });

}).call(this);
