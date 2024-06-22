import 'package:flutter/material.dart';
import 'package:online/feature/dashboard/input_user_birth_date.dart';
import 'package:online/util/app_util.dart';
import 'package:online/widget/custome_screen.dart';

class InputUserHeightScreen extends StatefulWidget {
  const InputUserHeightScreen(
      {super.key,
      required this.title,
      required this.description,
      this.kilogramm,
      required this.hintText});
  final String title;
  final String description;
  final double? kilogramm;
  final String hintText;

  @override
  State<InputUserHeightScreen> createState() => _InputUserHeightScreenState();
}

class _InputUserHeightScreenState extends State<InputUserHeightScreen> {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return keyboardDismisser(
      context: context,
      child: Scaffold(
        backgroundColor: HexColor("#50C276"),
        body: CustomerUserInfo(
          isAppbar: true,
          controller: controller,
          description: widget.description,
          hintText: widget.hintText,
          title: widget.title,
          inputType: TextInputType.number,
          onpress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => InputUserBirthDateScreen(
                          description: '',
                          kilogramm: widget.kilogramm,
                          title: 'What is your bithday?',
                          hintText: 'DD / MM / YYYY',
                          height: double.parse(controller.text),
                        ))));
          },
        ),
      ),
    );
  }
}

Widget keyboardDismisser({BuildContext? context, Widget? child}) {
  final gesture = GestureDetector(
    onTap: () {
      FocusScope.of(context!).requestFocus(FocusNode());
    },
    child: child,
  );
  return gesture;
}
