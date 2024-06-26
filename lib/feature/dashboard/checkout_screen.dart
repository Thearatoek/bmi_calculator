import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:online/model/food_model.dart';
import 'package:online/mybloc/bloc_bloc.dart';

import '../../util/app_util.dart';

class CheckOutScreen extends StatefulWidget {
  final FoodModel foodModel;
  final String? dateNum;
  final String? amountOfpackage;
  final double? nubmerofUnit;
  const CheckOutScreen(
      {super.key,
      required this.foodModel,
      this.dateNum,
      this.amountOfpackage,
      this.nubmerofUnit});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

final cardNumberController = TextEditingController();
final fullnameController = TextEditingController();
final cvcController = TextEditingController();
final mvmController = TextEditingController();
final List<String> cardInfo = ['CVV', 'MM/YY'];
final List<TextEditingController> _controller = [cvcController, mvmController];

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  void initState() {
    mytotalprice =
        double.parse(widget.foodModel.price!.replaceAll('\$', '').toString()) *
            double.parse(widget.nubmerofUnit.toString());
    super.initState();
  }

  final snackBar = AnimatedSnackBar.material(
    'Your payment is sucessed!',
    type: AnimatedSnackBarType.success,
    mobileSnackBarPosition: MobileSnackBarPosition.top,
    desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    snackBarStrategy: RemoveSnackBarStrategy(),
  );
  late double mytotalprice = 0;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocBloc>(context);
    return BlocConsumer<BlocBloc, BlocState>(
      listener: (context, state) async {
        if (state is BMIStoreDataState) {
          snackBar.show(context);
          await Future.delayed(const Duration(seconds: 2), () {
            snackBar.remove();
          });
        }
      },
      builder: (context, state) {
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
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.27,
                        child: Image.network(
                          widget.foodModel.image ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.foodModel.title ?? 'Hello',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.foodModel.price ?? '',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'Price per Unit ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.withOpacity(0.7)),
                                  )),
                                  Text(widget.foodModel.price.toString())
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
                                    'Number of Unit',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.withOpacity(0.7)),
                                  )),
                                  Text(widget.nubmerofUnit.toString())
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              child: Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    'Totoal Price: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                  Text(
                                    mytotalprice.toString(),
                                    style: const TextStyle(
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
                              Icons.radio_button_unchecked,
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
                                width: 0.5,
                                color: Colors.grey.withOpacity(0.6)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: TextField(
                            controller: cardNumberController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Card Number',
                                border: InputBorder.none),
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
                                width: 0.5,
                                color: Colors.grey.withOpacity(0.6)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: TextField(
                            controller: fullnameController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Full Name',
                                border: InputBorder.none),
                            onChanged: (text) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          cardInfo.length,
                          (index) {
                            var hintText = cardInfo[index];
                            return Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                // width: MediaQuery.of(context).size.width / 2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5,
                                        color: Colors.grey.withOpacity(0.6)),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: TextField(
                                    controller: _controller[index],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: hintText,
                                        border: InputBorder.none),
                                    onChanged: (text) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Dialogs.materialDialog(
                      barrierDismissible: true,
                      color: Colors.white,
                      titleAlign: TextAlign.center,
                      title:
                          'After the payment, you can not cancel the order, Are you sure to continous the order?',
                      lottieBuilder: Lottie.asset(
                        'asset/images/warning.json',
                        repeat: false,
                        fit: BoxFit.contain,
                      ),
                      context: context,
                      actions: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            bloc.add(BMIStoreEvent(widget.foodModel));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                            child: const Center(
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ]);
                },
                child: Container(
                  margin: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: const Center(
                    child: Text(
                      'Check out',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
