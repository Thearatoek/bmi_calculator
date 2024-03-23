import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online/util/app_util.dart';
import 'package:online/widget/custome_screen.dart';
import 'package:online/widget/success_screen.dart';

class InputUserBirthDateScreen extends StatefulWidget {
  const InputUserBirthDateScreen({super.key, required this.title, required this.description, this.kilogramm, required this.hintText, this.height});
  final String title;
  final String description;
  final double? kilogramm;
  final double? height;
  final String hintText;

  @override
  State<InputUserBirthDateScreen> createState() => _InputUserBirthDateScreenState();
}

class _InputUserBirthDateScreenState extends State<InputUserBirthDateScreen> {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double bmi = 0;
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
          inputType: TextInputType.datetime,
          inputFormatter: [DateTextFormatter()],
          onpress: () {
            bmi = bmiCalculator(widget.height!, widget.kilogramm!);
            Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessScreen(result: bmi)));
          },
        ),
      ),
    );
  }

  double bmiCalculator(double userheight, double userweight) {
    double a = userheight / 100;
    debugPrint("========$a");
    bmi = userweight / pow(a, 2);
    debugPrint("========$bmi");
    return bmi;
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

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String separator = '/';
    var text = _format(
      newValue.text,
      oldValue.text,
      separator,
    );

    return newValue.copyWith(
      text: text,
      selection: updateCursorPosition(
        oldValue,
        text,
      ),
    );
  }

  int min(int n1, int n2) {
    return [n1, n2].reduce((curr, next) => curr < next ? curr : next);
  }

  int max(int n1, int n2) {
    return [n1, n2].reduce((curr, next) => curr > next ? curr : next);
  }

  String _format(
    String value,
    String oldValue,
    String separator,
  ) {
    var isErasing = value.length < oldValue.length;
    var isComplete = value.length > _maxChars + 2;

    if (!isErasing && isComplete) {
      return oldValue;
    }

    value = value.replaceAll(separator, '');
    final result = <String>[];

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      result.add(value[i]);
      if ((i == 1 || i == 3) && i != value.length - 1) {
        result.add(separator);
      }
    }

    return result.join();
  }

  TextSelection updateCursorPosition(
    TextEditingValue oldValue,
    String text,
  ) {
    var endOffset = max(
      oldValue.text.length - oldValue.selection.end,
      0,
    );

    int selectionEnd = text.length - endOffset;

    return TextSelection.fromPosition(TextPosition(offset: selectionEnd));
  }
}
