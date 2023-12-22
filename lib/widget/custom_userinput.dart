import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  final String text;
  final String? scale;
  final TextEditingController contoller;
  final void Function(String value)? onChanged;
  const AppInputField({
    super.key,
    required this.text,
    required this.contoller,
    this.scale,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
        ),
        SizedBox(
          width: 70,
          height: 40,
          child: TextField(
            onChanged: onChanged,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(border: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black))),
          ),
        ),
      ],
    );
  }
}
