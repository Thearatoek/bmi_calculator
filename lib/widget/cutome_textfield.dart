import 'package:flutter/material.dart';

import '../util/app_util.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String scal;
  final String label;
  const CustomInputField({super.key, required this.controller, required this.label, required this.scal});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: scal != '' ? MediaQuery.of(context).size.width / 1 / 2.4 : MediaQuery.of(context).size.width / 1.5,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: HexColor('#CCF4F8'),
          ),
          child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ))),
        ),
        const SizedBox(
          width: 10,
        ),
        if (scal != '')
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: HexColor('#CCF4F8')),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text(
                    scal,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          )
      ],
    );
  }
}
