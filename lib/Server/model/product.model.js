const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;
const ProductSchema = new Schema({
    productname: {
        type: String,
        required: true,

    },
    description: {
        type: String,
        required: true,

    },
    price: {
        type: Number,
        required: true,
    },
    urlimg: {
        type: Buffer,
        required: true,

    },

});
const ProductModel = db.model('product', ProductSchema);
module.exports = ProductModel;