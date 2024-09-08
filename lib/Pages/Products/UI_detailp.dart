import 'package:ecomerce1/Pages/Products/ui_cart.dart';
import 'package:flutter/material.dart';
import 'package:ecomerce1/Models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.productname),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: widget.product.urlimg.isNotEmpty
                  ? Image.memory(
                widget.product.urlimg,
                fit: BoxFit.cover,
                width: double.infinity,
              )
                  : Center(child: Icon(Icons.image, size: 150)),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.productname,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.product.description,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Price: \$${widget.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Cart.addProduct(widget.product);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(),
                          ),
                        );
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Agregar al carrito',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$${widget.product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8)),
                        height: 100,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cart {
  static List<Product> _cartItems = [];

  static void addProduct(Product product) {
    _cartItems.add(product);
  }

  static List<Product> getCartItems() {
    return _cartItems;
  }
}
