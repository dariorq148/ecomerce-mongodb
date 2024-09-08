import 'dart:convert';
import 'package:ecomerce1/Models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:http/http.dart' as http;

class GridProducts extends StatefulWidget {
  const GridProducts({super.key});

  @override
  State<GridProducts> createState() => _GridProductsState();
}

class _GridProductsState extends State<GridProducts> {
  Future<List<Product>> fetchProducts() async {
    final response =
    await http.get(Uri.parse('http://192.168.1.220/getProducts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Skeletonizer(
                enabled: true,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay productos disponibles'));
        } else {
          final products = snapshot.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      product.urlimg.isNotEmpty
                          ? Image.memory(
                        product.urlimg,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        height: 100,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.productname,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('\$${product.price}'),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
