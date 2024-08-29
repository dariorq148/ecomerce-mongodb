import 'dart:convert';
import 'package:ecomerce1/Models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://localhost:3000/getProducts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Productos')),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay productos disponibles'));
          } else {
            final products = snapshot.data!;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return ListTile(
                  leading: product.urlimg.isNotEmpty
                      ? Image.memory(
                    product.urlimg,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                      : null,
                  title: Text(product.productname),
                  subtitle: Text(product.description),
                  trailing: Text('\$${product.price}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
