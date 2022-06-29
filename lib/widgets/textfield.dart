import 'package:flutter/material.dart';

class Textfieldinput extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool ispass;
  final String hintText;
  const Textfieldinput(
      {Key? key,
      required this.hintText,
      this.ispass = false,
      required this.textEditingController,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputborder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputborder,
        focusedBorder: inputborder,
        enabledBorder: inputborder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: ispass,
    );
  }
}
