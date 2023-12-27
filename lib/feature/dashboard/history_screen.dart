import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/model/user_model.dart';
import 'package:online/mybloc/bloc_bloc.dart';
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
  final _auth = FirebaseAuth.instance;
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
              return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection('client').where('uid', isEqualTo: _auth.currentUser?.uid).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<DocumentSnapshot> documents = snapshot.data!.docs;
                      return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                            double result = data['result'];
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: CustomCardWidget(
                                ontap: () async {
                                  setState(() {
                                    deleteItem(documents[index].id);
                                  });
                                  snackBar.show(context);
                                  await Future.delayed(const Duration(seconds: 2), () {
                                    snackBar.remove();
                                  });
                                },
                                height: '${data['height']}',
                                weight: '${data['weight']}',
                                result: result.toStringAsFixed(2),
                              ),
                            );
                          });
                    }
                  });
            }),
      ),
    );
  }

  Future<void> deleteItem(String itemId) async {
    try {
      // Replace 'your_collection' with the name of your collection
      String collectionName = 'client';

      // Get a reference to the document
      DocumentReference documentReference = FirebaseFirestore.instance.collection(collectionName).doc(itemId);
      await documentReference.delete();
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  final snackBar = AnimatedSnackBar.material(
    'Deleted an Item!',
    type: AnimatedSnackBarType.success,
    mobileSnackBarPosition: MobileSnackBarPosition.top,
    desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    snackBarStrategy: RemoveSnackBarStrategy(),
  );
}
