import 'dart:typed_data'; // Asegúrate de importar este paquete

class Product {
  final String productname;
  final String description;
  final double price;
  final Uint8List urlimg; // Cambia el tipo a Uint8List

  Product({
    required this.productname,
    required this.description,
    required this.price,
    required this.urlimg,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productname: json['productname'],
      description: json['description'],
      price: json['price'].toDouble(),
      urlimg: Uint8List.fromList(
          List<int>.from(json['urlimg']['data'])
      ),
    );
  }
}
