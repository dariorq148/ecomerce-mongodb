import 'dart:convert';
import 'package:ecomerce1/Models/product_model.dart';
import 'package:ecomerce1/Pages/Products/UI_detailp.dart';
import 'package:ecomerce1/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(getlistproducts));

      if (!mounted) return;
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        setState(() {
          products = jsonList.map((json) => Product.fromJson(json)).toList();
          isLoading = false;
        });


      } else {
        if (!mounted) return;
        setState(() {
          errorMessage = 'Failed to load products';
          isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : products.isEmpty
          ? Center(child: Text('No hay productos disponibles'))
          : ListView.builder(
        itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5,
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: product.urlimg.isNotEmpty
                    ? Image.memory(
                  product.urlimg,
                  width: 150,
                  height: 180,
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
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product,

                      ),
                    ),
                  );
                },
              ),
            );
          }

      ),
    );
  }
}
