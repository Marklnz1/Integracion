const express = require("express");
const app = express();
const cors = require("cors");
const soap = require("soap");
const url = "http://localhost:8000/PaymentService?wsdl";
const Product = require("./models/Product.js");
const User = require("./models/User.js");
const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

let dbURI =
  "mongodb+srv://user:$Password12$@cluster0.nybh2.mongodb.net/Inventory?retryWrites=true&w=majority";
start();
async function start() {
  await mongoose.connect(dbURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });
  soap.createClient(url, (err, client) => {
    if (err) {
      console.error(err);
      return;
    }

    app.use(cors());
    app.use(express.json());
    app.get("/products", async (req, res) => {
      let products = await Product.find().lean();
      res.json(products);
    });
    app.post("/login", async (req, res) => {
      const { username, password } = req.body;

      const userBD = await User.findOne({ username });
      if (!userBD) {
        res
          .status(201)
          .json({ error: "El usuario o la contraseña es incorrecta" });
        return;
      }
      const logeado = await bcrypt.compare(password, userBD.password);
      if (!logeado) {
        res
          .status(201)
          .json({ error: "El usuario o la contraseña es incorrecta" });
        return;
      }
      const token = jwt.sign({ username: userBD.username }, "efe", {
        expiresIn: 30000,
      });
      console.log("IDDDDDD",userBD._id.toString(),userBD._id);
      res.status(201).json({ message: "Usuario logeado correctamente", token,userId:userBD._id.toString() });
    });
    app.post("/register", async (req, res, next) => {
      const { password, username, name, phone } = req.body;
      console.log(req.body);
      const salt = await bcrypt.genSalt();
      let passwordBcrypt = await bcrypt.hash(password, salt);
      let newUser = User({ name, phone, username, password: passwordBcrypt });
      await newUser.save();
      res.status(201).json({ message: "usuario creado correctamente" });
    });
    app.post("/initiatePayment", async (req, res) => {
      let product = await Product.findById(req.body.products[0].id);
      if (product != null) {
       
        client.InitiatePayment(req.body,async (err, result) => {
          if (err) {
            console.error(err);
            return;
          }
          product.quantity--;
          await product.save();
          console.log(result);
          res.send(result);
        });
      }
    });
    app.post("/payments", async (req, res) => {
      console.log("ENTRE");
        client.Payments(req.body, (err, result) => {
          console.log("ENTREEEE",req.body);
          if (err) {
            // console.error(err);
            return;
          }
          // console.log(result);
          res.send(result);
        });
      
    });
    app.listen(3000, () => {
      console.log("Servidor escuchando en el puerto 3000.");
    });
  });
}
