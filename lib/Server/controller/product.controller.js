const multer = require('multer');
const ProductService = require('../services/product.service');

const ProductModel = require('../model/product.model'); // Asegúrate de que la ruta sea correcta

// Configuración de multer para manejar la subida de imágenes
const storage = multer.memoryStorage(); // Usar la memoria para almacenar el archivo temporalmente
const upload = multer({ storage: storage });

exports.register = async(req, res) => {
    try {
        const { productname, description, price, urlimg } = req.body;
        // Convertir la imagen 
        const imageBuffer = urlimg ? Buffer.from(urlimg, 'base64') : null;

        const success = await ProductService.registerProduct(productname, description, price, imageBuffer);
        res.json({ status: true, success: 'Producto registrado' });
    } catch (error) {
        res.status(500).json({ status: false, message: error.message });
    }
};


///ver 
exports.getAllProducts = async(req, res) => {
    try {
        const products = await ProductModel.find();
        console.log('Productos recuperados:', products);
        res.json(products);
    } catch (error) {
        console.error('Error al recuperar productos:', error.message);
        res.status(500).json({ status: false, message: error.message });
    }
};



//actualizar producto
exports.updateProduct = async(req, res) => {
    try {
        const { id } = req.params; // ID del producto a actualizar
        const { productname, description, price, urlimg } = req.body;

        // Convertir la imagen a Buffer si existe
        const imageBuffer = urlimg ? Buffer.from(urlimg, 'base64') : null;

        // Encontrar y actualizar el producto
        const updatedProduct = await ProductService.updateProduct(id, productname, description, price, imageBuffer);

        if (updatedProduct) {
            res.json({ status: true, message: 'Producto actualizado', product: updatedProduct });
        } else {
            res.status(404).json({ status: false, message: 'Producto no encontrado' });
        }
    } catch (error) {
        res.status(500).json({ status: false, message: error.message });
    }
};



///eliminar
exports.deleteProduct = async(req, res) => {
    try {
        const { id } = req.params; // ID del producto a eliminar

        const deletedProduct = await ProductService.deleteProduct(id);

        if (deletedProduct) {
            res.json({ status: true, message: 'Producto eliminado' });
        } else {
            res.status(404).json({ status: false, message: 'Producto no encontrado' });
        }
    } catch (error) {
        res.status(500).json({ status: false, message: error.message });
    }
};