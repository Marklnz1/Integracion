var xml = require("fs").readFileSync("service.wsdl", "utf8");
var soap = require("soap");
var express = require("express");
var bodyParser = require("body-parser");
const paymentService = require("./services/payment/paymentService");

const mongoose = require("mongoose");

let dbURI =
  "mongodb+srv://user:$Password12$@cluster0.nybh2.mongodb.net/Transaction?retryWrites=true&w=majority";
start();
async function start() {
  await mongoose.connect(dbURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });
  var app = express();
  // app.use(
  //   bodyParser.raw({
  //     type: function () {
  //       return true;
  //     },
  //     limit: "5mb",
  //   })
  // );
  app.listen(8000, function () {
    let server = soap.listen(
      app,
      "/PaymentService",
      paymentService,
      xml,
      function () {
        console.log("server initialized");
      }
    );
   
  });
}
