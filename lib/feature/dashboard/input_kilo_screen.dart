import 'package:flutter/material.dart';
import 'package:online/feature/dashboard/input_height_user_screen.dart';
import 'package:online/widget/custome_screen.dart';

import '../../util/app_util.dart';

class InputUserKiloScreen extends StatefulWidget {
  const InputUserKiloScreen({super.key});

  @override
  State<InputUserKiloScreen> createState() => _InputUserKiloScreenState();
}

class _InputUserKiloScreenState extends State<InputUserKiloScreen> {
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
          isAppbar: false,
          controller: controller,
          description: 'If you are not sure, you can update it later.',
          hintText: 'Kilograms',
          title: 'Please enter your current weight',
          inputType: TextInputType.number,
          onpress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => InputUserHeightScreen(
                          description: 'The taller you are, the more calories your body needs.',
                          kilogramm: double.parse(controller.text),
                          title: 'How tall are you?',
                          hintText: 'Centimeters',
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
