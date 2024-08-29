import 'package:flutter/material.dart';

class Responsivo {
  static double _screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static bool esCelular(BuildContext context) {
    return _screenWidth(context) < 600;
  }

  static bool esTablet(BuildContext context) {
    return _screenWidth(context) >= 600 && _screenWidth(context) < 1024;
  }

  static bool esLaptop(BuildContext context) {
    return _screenWidth(context) >= 1024;
  }

  static double tamanoFuente(BuildContext context) {
    if (esCelular(context)) {
      return 14.0;
    } else if (esTablet(context)) {
      return 18.0;
    } else {
      return 22.0;
    }
  }

  static double margen(BuildContext context) {
    if (esCelular(context)) {
      return 8.0;
    } else if (esTablet(context)) {
      return 16.0;
    } else {
      return 24.0;
    }
  }

  static int columnasGrid(BuildContext context) {
    if (esCelular(context)) {
      return 2;
    } else if (esTablet(context)) {
      return 4;
    } else {
      return 6;
    }
  }

  static EdgeInsets paddingGeneral(BuildContext context) {
    return EdgeInsets.all(margen(context));
  }
}
