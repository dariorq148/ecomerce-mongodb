import 'dart:convert';
import 'dart:typed_data';
import 'package:ecomerce1/Pages/Products/ui_listp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  final String productId;
  const AddProduct({super.key, required this.productId});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  Uint8List? _imageBytes;

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }
  Future<void> _insertProduct() async {
    if (_imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Por favor, selecciona una imagen antes de insertar el producto')),
      );
      return;
    }

    String base64Image = base64Encode(_imageBytes!);

    var reqBody = {
      'productname': _nameController.text,
      'description': _descriptionController.text,
      'price': _priceController.text,
      'urlimg': base64Image,
    };

    try {
      var response = await http.post(
        Uri.parse('http://localhost:3000/registerProduct'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reqBody),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Producto registrado exitosamente')),
        );
        _nameController.clear();
        _descriptionController.clear();
        _priceController.clear();
        setState(() {
          _imageBytes = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al insertar el producto'),
            backgroundColor: Colors.redAccent,
            elevation: 5,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          elevation: 5,
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Producto',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nombre del Producto",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Descripción",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Precio",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _selectImage,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                ),
                child:
                    Text('Seleccionar imagen', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 16),
            if (_imageBytes != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Image.memory(
                    _imageBytes!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _insertProduct,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                  backgroundColor: Colors.black,
                ),
                child: Text('Insertar producto',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                ),
                child: Text('Ver lista de productos',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
