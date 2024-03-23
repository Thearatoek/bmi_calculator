import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online/util/app_util.dart';

class CustomerUserInfo extends StatefulWidget {
  final String title;
  final String description;
  final TextEditingController? controller;
  final String hintText;
  final void Function()? onpress;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? inputType;
  final bool isAppbar;
  const CustomerUserInfo(
      {super.key,
      required this.title,
      required this.description,
      this.controller,
      required this.hintText,
      this.onpress,
      this.inputType,
      required this.isAppbar,
      this.inputFormatter});

  @override
  State<CustomerUserInfo> createState() => _CustomerUserInfoState();
}

class _CustomerUserInfoState extends State<CustomerUserInfo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            if (widget.isAppbar)
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, left: 20),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: widget.isAppbar ? 30 : MediaQuery.of(context).size.height * 0.16),
              child: const Center(
                child: Text(
                  "Karlory",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: TextField(
                  controller: widget.controller,
                  inputFormatters: widget.inputFormatter,
                  keyboardType: widget.inputType,
                  decoration: InputDecoration(hintText: widget.hintText, border: InputBorder.none),
                  onChanged: (text) {
                    setState(() {});
                    getValidate();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.description,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: widget.inputType == TextInputType.datetime ? 25 : 20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: getValidate() ? widget.onpress : errorValidation,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: getValidate() ? HexColor("#106D11") : Colors.grey),
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String errorValidation() {
    if (widget.controller!.text.isEmpty) {
      return "";
    }
    return "";
  }

  bool getValidate() {
    return widget.controller!.text.isNotEmpty;
  }
}
