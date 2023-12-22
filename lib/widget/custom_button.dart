import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonCustomWidget extends StatelessWidget {
  VoidCallback? onClick;
  String? name;
  bool isborder;

  ButtonCustomWidget({Key? key, this.onClick, this.name, required this.isborder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: isborder ? Colors.black : Colors.grey),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            name ?? "",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
