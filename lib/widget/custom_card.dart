import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final String result;
  final String weight;
  final String height;
  final Function ontap;
  const CustomCardWidget({super.key, required this.result, required this.weight, required this.height, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(.9),
              blurRadius: 0,
              spreadRadius: 1,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage('asset/images/bmi.jpeg'))),
              width: 80,
              height: 80,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          '$weight  kg',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$height Cm',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ontap();
              },
              child: const Icon(
                Icons.delete,
                size: 20,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
