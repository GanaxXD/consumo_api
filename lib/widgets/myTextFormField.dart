import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {

    final TextEditingController controller;
    final String hint, help;
    final TextInputType keyboardType;

    MyTextFormField({@required this.controller, @required this.hint, @required this.help, @required this.keyboardType});

    @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
            style: TextStyle(
                color: Colors.indigo,
                fontSize: 14,
                fontWeight: FontWeight.w500,
            ),
            keyboardType: keyboardType,
            controller: controller,
            expands: false,
            decoration: InputDecoration(
                hintText: hint,
                helperText: help,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
        ),
    );
  }
}
