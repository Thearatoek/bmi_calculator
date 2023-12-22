import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/feature/dashboard/dashboard_screen.dart';
import 'package:online/feature/login/login_screen.dart';
import 'package:online/model/user_model.dart';
import '../../mybloc/bloc_bloc.dart';

class CalculatorScreen extends StatefulWidget {
  final UserModel? userModel;
  const CalculatorScreen({
    super.key,
    this.userModel,
  });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}
// ignore: constant_identifier_names

class _CalculatorScreenState extends State<CalculatorScreen> {
  double bmi = 0;

  String status = '';

  double toDouble(String value) {
    if (value.isEmpty) return 0;

    return double.tryParse(value) ?? 0;
  }

  @override
  void initState() {
    context.read<BlocBloc>().add(InitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocBloc, BlocState>(
      listener: (context, state) {
        if (state is RegisterUserState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => BlocBloc(),
                child: const LoginScreen(),
              ),
            ),
          );
        } else if (state is BMIthearaState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => BlocBloc(),
                child: const DashboardScreen(
                  username: 'Vanda',
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return Container(
              width: double.infinity, height: double.infinity, color: Colors.white, child: const Center(child: CircularProgressIndicator()));
        }

        return const Text('');
      },
    );
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

  double bmiCalculator(double userheight, double userweight) {
    double a = userheight / 100;
    bmi = userweight / pow(a, 2);
    debugPrint("========$bmi");
    return bmi;
  }
}
