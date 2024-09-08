import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:ecomerce1/Auth/auth.dart';
import 'package:ecomerce1/Pages/Products/ui_cart.dart';
import 'package:ecomerce1/Pages/Products/ui_listp.dart';
import 'package:ecomerce1/Pages/Sells/ui_purchase_.dart';
import 'package:ecomerce1/Pages/Users/ui_userlist.dart';
import 'package:ecomerce1/Pages/insert_product.dart';
import 'package:ecomerce1/Widgets/SliderOFF.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UI_Homep extends StatefulWidget {
  final String username;  final String productId;

  const UI_Homep({super.key, required this.username, required this.productId});

  @override
  State<UI_Homep> createState() => _UI_HomepState();
}

class _UI_HomepState extends State<UI_Homep> {
  TextEditingController _searchbar = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _logout() async {
    final authService = AuthService();
    await authService.clearCredentials();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Skeletonizer(
          enabled: _isLoading,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/bk3.jpg',
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.repeat,
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(360),
                                          color: Colors.transparent),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hola ${widget.username}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Disfruta las mejores ofertas \n que tenemos para ti.',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CartScreen(),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.shopping_cart_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: AnimSearchBar(
                            width: double.maxFinite,
                            textController: _searchbar,
                            onSuffixTap: () {},
                            onSubmitted: (p8) {},
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          child: Slideroff(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Categorias',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white)),
                              Text(
                                'Ver todo',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddProduct(
                                                      productId: widget.productId,
                                                    ),
                                              ));
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.ac_unit_sharp,
                                                color: Colors.black,
                                              ),
                                              Text(
                                                'Refrigeradoras',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: _logout,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.account_balance_sharp,
                                                color: Colors.black,
                                              ),
                                              Text(
                                                'Para el hogar',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PurchaseListPage(),
                                              ));
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.account_tree_outlined,
                                                color: Colors.black,
                                              ),
                                              Text(
                                                'Cables',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UserListScreen(),
                                              ));
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.tv,
                                                color: Colors.black,
                                              ),
                                              Text(
                                                'Tv',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.wallet_outlined,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'mas vendidos',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),

                                ///container 2

                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.qr_code_2,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'Tinka',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.event_seat,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'Muebles',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.g_translate,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'Traductores',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.adb_outlined,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'Celulares Android',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.join_inner_outlined,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'Autos',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ProductListScreen(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
