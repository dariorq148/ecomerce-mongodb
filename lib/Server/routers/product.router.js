const router = require('express').Router();
const ProductController = require('../controller/product.controller');

router.post('/registerProduct', ProductController.register);
router.get('/getProducts', ProductController.getAllProducts);
router.put('/updateProduct/:id', ProductController.updateProduct); // Actualizar un producto
router.delete('/deleteProduct/:id', ProductController.deleteProduct); // Eliminar un producto

module.exports = router;