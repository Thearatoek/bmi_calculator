import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Exercise"),
        leading: const Icon(Icons.run_circle_rounded),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _customItemWidget(
                imgage: 'asset/images/run.png',
                title: 'Running',
                calories: '250 cals'),
            const SizedBox(
              height: 20,
            ),
            _customItemWidget(
                imgage: 'asset/images/walk.png',
                title: 'Running',
                calories: '250 cals'),
            const SizedBox(
              height: 20,
            ),
            _customItemWidget(
                imgage: 'asset/images/bike.png',
                title: 'Running',
                calories: '250 cals'),
            const SizedBox(
              height: 20,
            ),
            _customItemWidget(
                imgage: 'asset/images/swim.png',
                title: 'Running',
                calories: '250 cals'),
            const SizedBox(
              height: 20,
            ),
            _customItemWidget(
                imgage: 'asset/images/jump.png',
                title: 'Running',
                calories: '250 cals')
          ],
        ),
      ),
    );
  }
}

Widget _customItemWidget(
    {required String imgage, required String title, required String calories}) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(imgage), fit: BoxFit.cover)),
      ),
      const SizedBox(
        width: 20,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Row(
            children: [
              Text(
                calories,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.green),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('/'),
              ),
              const Text("30 mn")
            ],
          )
        ],
      )
    ],
  );
}
