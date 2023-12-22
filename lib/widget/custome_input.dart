import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputTextCustomWidget extends StatelessWidget {
  TextEditingController? controller;
  String? name;
  Icon? icon;
  bool? password;
  VoidCallback? onchange;

  InputTextCustomWidget({Key? key, this.controller, this.name, this.icon, this.password, this.onchange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        onChanged: (value) => onchange,
        obscureText: password ?? false,
        controller: controller,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Please enter $name";
          }
          return null;
        },
        decoration: InputDecoration(
            prefixIcon: icon, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)), label: Text(" $name"), hintText: " $name"),
      ),
    );
  }
}
