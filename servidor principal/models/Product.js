const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const productSchema = new Schema({
    name: String,
    description: String,
    price: Number,
    quantity:Number
  });
module.exports = mongoose.model('product',productSchema,"product");