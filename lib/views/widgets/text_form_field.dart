import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labeText;
  final bool obscureText;
  final Function onSave;
  final Function validate;
  final TextEditingController controller;

  const CustomTextFormField(
      {this.labeText,
      this.onSave,
      this.validate,
      this.obscureText = false,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        labelText: labeText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
      ),
      obscureText: obscureText,
      onSaved: onSave,
      validator: validate,
    );
  }
}
