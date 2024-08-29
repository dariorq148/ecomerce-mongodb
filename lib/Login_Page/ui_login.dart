import 'dart:convert';
import 'dart:ui';

import 'package:ecomerce1/Login_Page/ui_register.dart';
import 'package:ecomerce1/Pages/ui_homepage.dart';
import 'package:ecomerce1/Responsive/responsive.dart';
import 'package:ecomerce1/Widgets/widget_textfield.dart';
import 'package:ecomerce1/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UI_Login extends StatefulWidget {
  const UI_Login({super.key});

  @override
  State<UI_Login> createState() => _UI_LoginState();
}

class _UI_LoginState extends State<UI_Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
void limpiar(){
  email.clear();
  pass.clear();
}
  void loginUser() async {
    if (email.text.isNotEmpty && pass.text.isNotEmpty) {
      var reqBody = {'email': email.text, 'password': pass.text};

      try {
        var response = await http.post(
          Uri.parse(loger), // Asegúrate de que esta es la URL correcta
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(reqBody),
        );

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse['status']) {
            // Login exitoso
            print(jsonResponse['success']);
            limpiar();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UI_Homep(),
              ),
            );
          } else {
            // Mostrar error
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(jsonResponse['message']),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        } else {
          print('Failed to login user: ${response.statusCode}');
        }
      } catch (e) {
        print('Error occurred: $e');
      }
    } else {
      print('Email and password cannot be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxContainerWidth =
        Responsivo.esLaptop(context) ? 600 : double.infinity;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'assets/bkg3.jpg',
            fit: BoxFit.cover,
          )),
          Center(
            child: Padding(
              padding: Responsivo.paddingGeneral(context),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxContainerWidth,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                    child: Container(
                      height: 300,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white, width: 1)),
                      child: Column(
                        children: [
                          Text(
                            'Log in',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 25),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          buildTextField(context, email, Icons.alternate_email,
                              'email', '@ejemplo.com'),
                          SizedBox(
                            height: 20,
                          ),
                          buildTextField(context, pass, Icons.password,
                              'Contraseña', '**********',
                              obscureText: true),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Aun no tienes una cuenta?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UI_Registerpg(),
                                        ));
                                  },
                                  child: Text(
                                    ' inicia aqui',
                                    style: TextStyle(color: Colors.tealAccent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            child: ElevatedButton(
                                onPressed: loginUser,
                                child: Text(' Iniciar sesion')),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
