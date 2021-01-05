import 'package:flutter/material.dart';
TextFormField buildTextFormField({String hint,bool isPassword=false,int max,TextInputType type,TextEditingController customController}) {
  return TextFormField(
    autofocus: false,
    maxLength: max,
    obscureText:isPassword ,
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    },
    keyboardType: type,
    controller: customController,
    decoration: InputDecoration(
      counterText: "",
      filled: true,
      fillColor: Colors.grey[200],
      hintText: hint,
      contentPadding:
      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25.7),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25.7),
      ),
    ),
  );
}

class CustomClipPath extends CustomClipper<Path> {
  var radius=10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height,
        size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}