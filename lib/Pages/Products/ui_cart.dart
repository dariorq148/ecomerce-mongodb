
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecomerce1/Models/product_model.dart';
import 'package:ecomerce1/Pages/Products/UI_detailp.dart';
import 'package:ecomerce1/config.dart';

import '../../Auth/auth.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  double _calculateTotal(List<Product> cartItems) {
    double total = 0.0;
    for (var product in cartItems) {
      total += product.price * product.quantity;
    }
    return total;
  }

  Future<void> realizarCompra(BuildContext context,
      String userId, List<Map<String, dynamic>> productos) async {
    try {
      final requestBody = jsonEncode({
        'buyerId': userId,
        'products': productos,
      });

      print('Enviando JSON: $requestBody');

      final response = await http.post(
        Uri.parse(purchase),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status']) {
          print('Compra realizada con éxito: ${data['purchase']}');

        } else {
          print('Error al realizar la compra: ${data['message']}');
        }
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print('Error en la compra: $error');
    }
  }




  @override
  Widget build(BuildContext context) {
    final cartItems = Cart.getCartItems();
    final total = _calculateTotal(cartItems);

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('No hay productos en el carrito'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: product.urlimg.isNotEmpty
                              ? Image.memory(
                                  product.urlimg,
                                  width: 100,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                              : Icon(Icons.image, size: 100),
                          title: Text(
                            product.productname,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            '\$${(product.price * product.quantity).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final authService = AuthService();
                        final credentials = await authService.loadCredentials();
                        print('Credentials loaded: $credentials');
                        final userId = credentials['userId'];

                        if (userId == null) {
                          print('No se encontró el userId');
                          return;
                        }

                        final productos = cartItems
                            .map((item) => {
                                  'productId': item.id,
                                  'quantity': item.quantity,
                                })
                            .toList();

                        await realizarCompra(context,userId, productos);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Compra realizada con éxito'),
                          ),
                        );
                      },
                      child: Text(
                        'Pagar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    )),
              ],
            ),
    );
  }
}
