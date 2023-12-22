import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:online/feature/dashboard/history_screen.dart';
import 'package:online/model/user_model.dart';
import 'package:online/mybloc/bloc_bloc.dart';
import 'package:online/widget/donut_chart.dart';

import '../../util/app_util.dart';

class ResultScreen extends StatefulWidget {
  final UserModel usermodel;
  const ResultScreen({
    super.key,
    required this.usermodel,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late BlocBloc submitInfo = BlocProvider.of<BlocBloc>(context);
  String status = '';
  @override
  void initState() {
    showStatus(double.parse(widget.usermodel.result.toString()));
    super.initState();
  }

  String showStatus(double result) {
    if (result <= 15.9) {
      status = 'Very Severely Underweight';
    } else if (16 <= result && result <= 16.9) {
      status = 'Severely Underweight';
    } else if (17 <= result && result <= 18.4) {
      status = 'Underweight';
    } else if (18.5 <= result && result <= 24.9) {
      status = 'Normal';
    } else if (25 <= result && result <= 29.9) {
      status = 'Overweight';
    } else if (30 <= result && result <= 34.9) {
      status = 'Obese';
    } else if (35 <= result && result <= 39.9) {
      status = 'Hight Obese';
    } else if (39.9 <= result) {
      status = 'Extremly Obese';
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocBloc, BlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(true);
            },
            child: Scaffold(
                appBar: AppBar(
                  systemOverlayStyle: const SystemUiOverlayStyle(systemNavigationBarColor: Colors.black, statusBarColor: Colors.black),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  centerTitle: true,
                  title: const Text(
                    "BMI Result",
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                body: BlocConsumer<BlocBloc, BlocState>(
                  listener: (context, state) {
                    if (state is RecordedState) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => BlocBloc(),
                            child: HistoryScreen(
                              listUsermodel: state.listUsermodel,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 250,
                                height: 250,
                                child: AppCircleChart(
                                  value: widget.usermodel.result,
                                ),
                              ),
                              Text(status, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: HexColor('#CCF4F8')),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [const Text('Age'), Text('${widget.usermodel.age}')],
                                        ),
                                        Container(
                                          width: 1,
                                          height: 55,
                                          color: Colors.grey,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [const Text('Weight'), Text(widget.usermodel.weight!.toStringAsFixed(0))],
                                        ),
                                        Container(
                                          width: 1,
                                          height: 55,
                                          color: Colors.grey,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [const Text('Height'), Text(widget.usermodel.height!.toStringAsFixed(0))],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    Dialogs.materialDialog(
                                        color: Colors.white,
                                        title: 'Record Saved',
                                        lottieBuilder: Lottie.asset(
                                          'asset/images/tick.json',
                                          repeat: false,
                                          fit: BoxFit.contain,
                                        ),
                                        context: context,
                                        actions: [
                                          GestureDetector(
                                            onTap: () {
                                              submitInfo.add(BMIStoreEvent(widget.usermodel));
                                              submitInfo.add(RecordedEvent());
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.green,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Save and View History',
                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ]);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: HexColor('#35D2E9')),
                                    child: const Center(
                                        child: Text(
                                      'Save it',
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                )),
          );
        });
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
