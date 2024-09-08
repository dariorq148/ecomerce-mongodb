import 'package:ecomerce1/Models/purcase_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PurchaseDetailsPage extends StatelessWidget {
  final Purchase purchase;

  PurchaseDetailsPage({required this.purchase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Venta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comprador: ${purchase.buyerId.email}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Total: \$${purchase.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Fecha de compra: ${purchase.purchaseDate.toLocal().toString().split(' ')[0]}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Productos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: purchase.products.length,
                itemBuilder: (context, index) {
                  final product = purchase.products[index];
                  return ListTile(
                    title: Text('${product.productName}'),
                    subtitle: Text(
                        'Cantidad: ${product.quantity} - Precio: \$${product.price}'),
                    trailing: Text(
                        'Total: \$${(product.price * product.quantity).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
