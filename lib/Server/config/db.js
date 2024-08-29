const mongoose = require('mongoose');
const Connection = mongoose.createConnection(
    'mongodb+srv://darioramosq:darioramosq@cluster0.1soycpu.mongodb.net/ecomerce?retryWrites=true&w=majority&appName=Cluster0'
).on('open', () => {
    console.log('Mongo is connected');
}).on('error', () => {
    console.log('Mongo connection error');
});

module.exports = Connection;