import 'dart:convert';
import 'dart:ui';

import 'package:ecomerce1/Login_Page/ui_login.dart';
import 'package:ecomerce1/Responsive/responsive.dart';
import 'package:ecomerce1/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../Widgets/widget_textfield.dart';
import 'package:http/http.dart' as http;

class UI_Registerpg extends StatefulWidget {
  const UI_Registerpg({super.key});

  @override
  State<UI_Registerpg> createState() => _UI_RegisterpgState();
}

class _UI_RegisterpgState extends State<UI_Registerpg> {
  TextEditingController nombre = TextEditingController();
  TextEditingController apellidos = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  void limpiar() {
    nombre.clear();
    apellidos.clear();
    email.clear();
    password.clear();
    confirmpass.clear();
  }

  void registrar_usuario() async {
    if (nombre.text.isNotEmpty &&
        apellidos.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        confirmpass.text.isNotEmpty) {
      var reqBody = {
        'name': nombre.text,
        'lastname': apellidos.text,
        'email': email.text,
        'password': password.text,
      };
      try {
        var response = await http.post(Uri.parse(register),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(reqBody));
        if (response.statusCode == 200) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Exito'),
                content: Text('Te has registrado Exitosamente'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              );
            },
          );
          print('usuario registrado');
          limpiar();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UI_Login(),
              ));
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                title: Text('Error'),
                content:
                    Text(reqBody['message'] ?? 'error al registrar usuario'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              );
            },
          );
          print('error al registrar usuario');
        }
      } catch (e) {
        print('error ${e}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determinamos el ancho máximo que puede tomar el contenedor para asegurar que no se alargue demasiado
    double maxContainerWidth =
        Responsivo.esLaptop(context) ? 600 : double.infinity;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bkg3.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: Responsivo.paddingGeneral(context),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContainerWidth),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Text(
                              'Regístrate',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Responsivo.tamanoFuente(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          buildTextField(context, nombre, Icons.person,
                              'Nombre:', '---- ----'),
                          SizedBox(height: 20),
                          buildTextField(context, apellidos, Icons.person,
                              'Apellidos:', '---- ----'),
                          SizedBox(height: 20),
                          buildTextField(context, email, Icons.alternate_email,
                              'e-mail:', '@ejemplo.com'),
                          SizedBox(height: 20),
                          buildTextField(context, password, Icons.password,
                              'Contraseña:', '*********',
                              obscureText: true),
                          SizedBox(height: 20),
                          buildTextField(context, confirmpass, Icons.password,
                              'Confirmar contraseña:', '*******',
                              obscureText: true),
                          SizedBox(height: 30),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UI_Login(),
                                      ));
                                },
                                child: Text(
                                  '¿Tienes una cuenta? Inicia aquí',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Padding(
                                padding: Responsivo.paddingGeneral(context),
                                child: Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.transparent),
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          side: BorderSide(
                                              color: Colors.white, width: 1),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (password.text != confirmpass.text) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              icon: Icon(Icons.warning),
                                              title: Text('Error'),
                                              content: Text(
                                                  'Las contraseñas no coinciden'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Ok'))
                                              ],
                                            );
                                          },
                                        );
                                      }
                                      registrar_usuario();
                                    },
                                    child: Text(
                                      'Registrar',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
