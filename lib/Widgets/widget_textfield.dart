import 'package:flutter/material.dart';

Widget buildTextField(BuildContext context, TextEditingController controller,
    IconData icon, String label, String hintText,
    {bool obscureText = false}) {
  return Container(
    height: 40,
    child: Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          filled: true,
          fillColor: Colors.transparent,
          hintText: hintText,
          label: Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
