import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  String? hint;
  TextEditingController? controller;
  MyTextField({Key? key, this.controller, this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          label: Text(hint.toString()),
        ),
        validator: (value) => value!.isEmpty ? "Field can not be empty" : null,
      ),
    );
  }
}
