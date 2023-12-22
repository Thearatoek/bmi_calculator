import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/model/user_model.dart';
import 'package:online/mybloc/bloc_bloc.dart';
import 'package:online/util/app_util.dart';
import 'package:online/widget/custom_card.dart';

import '../auth_provider/authetication.dart';

class HistoryScreen extends StatefulWidget {
  final List<UserModel> listUsermodel;
  const HistoryScreen({super.key, required this.listUsermodel});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late BlocBloc conference = BlocProvider.of<BlocBloc>(context);
  final authen = UserAuth();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              widget.listUsermodel.clear();
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 22,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        body: BlocConsumer<BlocBloc, BlocState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                            colors: [HexColor('#919DFD'), HexColor('#9FDAFE')],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            stops: const [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: const [
                            Text('Available Record', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Total',
                              style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: widget.listUsermodel.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {},
                          child: CustomCardWidget(
                            ontap: () {
                              debugPrint("Hello");
                              conference.add(DeleteEvent());
                            },
                            weight: e.weight!.toStringAsFixed(0),
                            height: e.height!.toStringAsFixed(0),
                            result: e.result!.toStringAsFixed(2),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
