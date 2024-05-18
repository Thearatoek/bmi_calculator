import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:online/feature/dashboard/input_height_user_screen.dart';

import '../../util/app_util.dart';
import '../../widget/custome_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

final cardNumberController = TextEditingController();
final fullnameController = TextEditingController();

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text(
          'Check Out',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.27,
              child: Image.network(
                "https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=861,h=600,fit=crop/AwvL7WbqRLHXekVz/keto-diet-foods-1-ALpX60x9bkIGbMow.webp",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Intermitten Fasting 12: 12",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "\$20.00",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: HexColor("#106D11"),
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
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(4, 5),
                    blurRadius: 1,
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Price Details ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Price per packages: ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.withOpacity(0.7)),
                        )),
                        const Text('20')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Amount of Days: ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.withOpacity(0.7)),
                        )),
                        const Text('20')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Amount of Packages ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.withOpacity(0.7)),
                        )),
                        const Text('20')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Totoal Price: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                        Text(
                          '20 \$',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            const Text(
              'Payment Method: ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Image.network(
                    'https://cdn1.iconfinder.com/data/icons/credit-card-icons/512/visa.png',
                    width: 80,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                  const Expanded(
                    child: Text(
                      "Credit card",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.check_circle_sharp,
                    color: Colors.green,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSL_E0AF1Gm_V-i-uV5cfC4UGgqZQUc1fEJ2Nf6zJUemqNWVvd78uFpU8kpj4X4W6YmXA&usqp=CAU',
                    width: 80,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                  const Expanded(
                    child: Text(
                      "Cash",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.check_circle_sharp,
                    color: Colors.green,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.5, color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: TextField(
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Card Number', border: InputBorder.none),
                  onChanged: (text) {
                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.5, color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: TextField(
                  controller: fullnameController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Full Name', border: InputBorder.none),
                  onChanged: (text) {
                    setState(() {});
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5, color: Colors.grey.withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: TextField(
                        controller: fullnameController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Full Name', border: InputBorder.none),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: Colors.grey.withOpacity(0.6)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: TextField(
                      controller: fullnameController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Full Name', border: InputBorder.none),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
