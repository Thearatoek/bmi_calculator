import 'package:flutter/material.dart';
import 'package:online/feature/dashboard/purhcase_information.dart';
import 'package:online/util/app_util.dart';

class PuchaseScreen extends StatefulWidget {
  final String image;
  const PuchaseScreen({super.key, required this.image});

  @override
  State<PuchaseScreen> createState() => _PuchaseScreenState();
}

class _PuchaseScreenState extends State<PuchaseScreen> {
  final listOfInfo = [
    "Calories   1200 cals",
    "Carb   3g",
    "Protein   5g",
    "Fat   6g"
  ];
  late int indexClicked = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Since most of the fasting window occurs while you re sleeping, this IF method might be a good choice for beginners.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.6)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                direction: Axis.horizontal,
                children: listOfInfo.map((e) {
                  return custombox(e, getColorGenerate(e));
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("1 Package: ",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                Text(
                  "\$20.00",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#106D11"),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const PuchaseInformationScreen()));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: HexColor("#4FC376")),
                child: const Center(
                  child: Text("Purchase",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.black.withOpacity(0.3),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Daily Food: ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          indexClicked = index;
                          setState(() {});
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: indexClicked == index
                                ? Colors.greenAccent
                                : Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text("${index + 1}"),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.cover)),
            ),
          ],
        ),
      ),
    );
  }
}

Widget custombox(String title, Color color) {
  return Container(
    width: 120,
    height: 33,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(8), color: color),
    child: Center(
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    ),
  );
}

Color getColorGenerate(String title) {
  if (title == "Carb   3g") {
    return Colors.greenAccent;
  }
  if (title == "Protein   5g") {
    return Colors.blue;
  }
  if (title == "Fat   6g") {
    return Colors.amberAccent;
  }
  return Colors.green;
}
