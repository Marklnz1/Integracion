const mongoose = require("mongoose");

const paymentSchema = new mongoose.Schema({
  currency: String,
  userId:String,
  date: {
    type: Date,
    default: Date.now,
  },
  products: [
    {
      name: String,
      quantity: Number,
      price: Number,
    },
  ],
});

// Compile the schema into a model
module.exports =  mongoose.model("payment", paymentSchema, "payment");
