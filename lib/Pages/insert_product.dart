import 'dart:convert';
import 'dart:typed_data';
import 'package:ecomerce1/Pages/view_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  TextEditingController nombrep = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  Uint8List? imageBytes; // Variable para almacenar la imagen seleccionada

  // Método para seleccionar la imagen desde la galería
  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes(); // Lee los bytes de la imagen
      setState(() {
        imageBytes = bytes; // Actualiza el estado con los bytes de la imagen
      });
    }
  }

  void insertp() async {
    if (imageBytes == null) {
      print('Por favor, selecciona una imagen antes de insertar el producto');
      return;
    }

    String base64Image = base64Encode(imageBytes!);

    var reqbody = {
      'productname': nombrep.text,
      'description': description.text,
      'price': price.text,
      'urlimg': base64Image // Aquí se asegura de enviar la imagen en base64
    };

    print(
        'Datos enviados: $reqbody'); // Añadir esta línea para verificar los datos antes de enviarlos

    try {
      var response = await http.post(
        Uri.parse('http://localhost:3000/registerProduct'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reqbody),
      );
      if (response.statusCode == 200) {
        print('Producto registrado');
        print(response.body);
      } else {
        print('Error al insertar');
        print(response.body); // Imprimir la respuesta del servidor
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TextField(
              controller: nombrep,
              decoration: InputDecoration(labelText: "Nombre del Producto"),
            ),
          ),
          Container(
            child: TextField(
              controller: description,
              decoration: InputDecoration(labelText: "Descripción"),
            ),
          ),
          Container(
            child: TextField(
              controller: price,
              decoration: InputDecoration(labelText: "Precio"),
            ),
          ),
          ElevatedButton(
            onPressed: selectImage,
            child: Text('Seleccionar imagen'),
          ),
          if (imageBytes != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.memory(
                imageBytes!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ElevatedButton(
            onPressed: insertp,
            child: Text('Insertar producto'),
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListScreen(),
                    ));
              },
              child: Text('ver lista'))
        ],
      ),
    );
  }
}
