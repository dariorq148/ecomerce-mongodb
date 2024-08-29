            const ProductModel = require('../model/product.model');

            class ProductService {
                static async registerProduct(productname, description, price, base64Image) {
                    try {
                        // Validar si base64Image es nulo
                        let imageBuffer;
                        if (base64Image) {
                            imageBuffer = Buffer.from(base64Image, 'base64');
                        }

                        const createProduct = new ProductModel({
                            productname,
                            description,
                            price,
                            urlimg: imageBuffer // Solo agregar la imagen si existe
                        });

                        return await createProduct.save();
                    } catch (error) {
                        console.error('Error al insertar producto:', error.message);
                        throw new Error('Error al insertar producto: ' + error.message);
                    }
                }


                ///llamamos a actualizar 
                static async updateProduct(id, productname, description, price, urlimg) {
                    try {
                        const updatedProduct = await ProductModel.findByIdAndUpdate(
                            id, { productname, description, price, urlimg }, { new: true } // Devolver el documento actualizado
                        );
                        return updatedProduct;
                    } catch (error) {
                        console.error('Error al actualizar producto:', error.message);
                        throw new Error('Error al actualizar producto: ' + error.message);
                    }
                }

                //llamamos a actualizar
                static async deleteProduct(id) {
                    try {
                        const deletedProduct = await ProductModel.findByIdAndDelete(id);
                        return deletedProduct;
                    } catch (error) {
                        console.error('Error al eliminar producto:', error.message);
                        throw new Error('Error al eliminar producto: ' + error.message);
                    }
                }

            }


            module.exports = ProductService;