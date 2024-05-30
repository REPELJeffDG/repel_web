import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget registerTextField(TextEditingController controller, String title,
    bool obscure, bool readonly) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $title';
        } else if (value.length < 4) {
          return 'Please enter a valid $title';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
      ),
      controller: controller,
      obscureText: obscure,
      readOnly: readonly,
    ),
  );
}

Widget profileTextField(TextEditingController controller, String title,
    bool obscure, bool readonly) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
    child: TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
      ),
      controller: controller,
      obscureText: obscure,
      readOnly: readonly,
    ),
  );
}
