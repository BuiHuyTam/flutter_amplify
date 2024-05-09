import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final hintText;
  final obscurText;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscurText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: obscurText,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: Colors.grey.shade200),
      ),
    );
  }
}
