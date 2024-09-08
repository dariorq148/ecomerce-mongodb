import 'dart:convert';
import 'package:ecomerce1/Models/purcase_model.dart';
import 'package:ecomerce1/Pages/Sells/ui_detailsale.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PurchaseListPage extends StatefulWidget {
  @override
  _PurchaseListPageState createState() => _PurchaseListPageState();
}

class _PurchaseListPageState extends State<PurchaseListPage> {
  List<Purchase> purchases = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPurchases();
  }

  Future<void> fetchPurchases() async {
    final url = Uri.parse('http://192.168.56.1:3000/purchases');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> purchasesList = jsonResponse['purchases'];

        setState(() {
          purchases = purchasesList.map((json) => Purchase.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Error al cargar las ventas');
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ventas Realizadas'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: purchases.length,
        itemBuilder: (context, index) {
          final purchase = purchases[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text('Total: \$${purchase.totalPrice.toStringAsFixed(2)}'),
              subtitle: Text('Fecha: ${purchase.purchaseDate.toLocal().toString().split(' ')[0]}'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PurchaseDetailsPage(purchase: purchase),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

