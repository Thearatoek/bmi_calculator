import 'package:flutter/material.dart';
import 'package:online/feature/dashboard/recommendation_screen.dart';
import 'package:online/util/app_util.dart';

class SuccessScreen extends StatefulWidget {
  final double result;
  const SuccessScreen({super.key, required this.result});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final titleList = ["Lose Weight", "Gain weight", "Maintain Current Weight"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#50C276"),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1, left: 10),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.035),
            child: const Center(
              child: Text(
                "Karlory",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Your BMI is ",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  "${widget.result.toStringAsFixed(1)} ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: HexColor("#4285F4")),
                ),
              ),
              Text(
                getConsideredText(),
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "What is your Goal?",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          const SizedBox(
            height: 30,
          ),
          ...List.generate(titleList.length, (index) {
            final title = titleList[index];
            return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecommendationScreen(
                                      statusType: title,
                                    )));
                      },
                      child:
                          customContainer(title, checkReccomendation(title))),
                ));
          })
        ],
      ),
    );
  }

  Widget customContainer(String title, bool bimValue) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        if (bimValue)
          Positioned(
            top: -10,
            left: 70,
            right: 70,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: HexColor("#3AFC09")),
              child: const Center(
                child: Text("Recommendation"),
              ),
            ),
          )
      ],
    );
  }

  bool checkReccomendation(String title) {
    return widget.result <= 18.5 && title == "Lose Weight" ||
        widget.result >= 25.0 && title == "Gain weight";
  }

  String getConsideredText() {
    if (widget.result <= 18.5) {
      return "Underweight";
    }
    if (widget.result >= 25 || widget.result <= 29.9) {
      return "Healthy weight";
    }
    if (widget.result >= 30) {
      return "Overweight";
    }
    return "";
  }
}
