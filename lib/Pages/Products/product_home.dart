import 'package:ecomerce1/Pages/Products/gridProducts.dart';
import 'package:flutter/material.dart';


class ProductHome extends StatefulWidget {
  const ProductHome({super.key});

  @override
  State<ProductHome> createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(padding: EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 200,
              color: Colors.tealAccent,
            ),
            GridProducts()
          ],
        ),
      ),
      ),
    );
  }
}
