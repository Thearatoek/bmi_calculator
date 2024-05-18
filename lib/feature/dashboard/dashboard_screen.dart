import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:circular/circular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:online/feature/dashboard/history_screen.dart';
import 'package:online/feature/dashboard/result_screen.dart';
import 'package:online/feature/login/login_screen.dart';
import 'package:online/mybloc/bloc_bloc.dart';

import '../../model/user_model.dart';
import '../../util/app_util.dart';

class DashboardScreen extends StatefulWidget {
  final String username;
  const DashboardScreen({super.key, required this.username});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late BlocBloc transferdata = BlocProvider.of<BlocBloc>(context);
  bool get isKeyboardAppear => MediaQuery.of(context).viewInsets.bottom > 0;
  var ageUserController = TextEditingController();
  var weightController = TextEditingController();
  var heightController = TextEditingController();
  double height = 0;
  double weight = 0;
  List<RulerRange> ranges = const [
    RulerRange(
      begin: 0,
      end: 200,
    ),
  ];
  RulerPickerController? _rulerPickerController;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    height = 150;
    _rulerPickerController = RulerPickerController(value: 150);
    super.initState();
  }

  bool ismale = false;
  bool isfemale = false;
  String gender = '';
  double age = 0;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocBloc, BlocState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          debugPrint("hello=========================");
          snackBar.show(context);

          Future.delayed(const Duration(seconds: 2), () {
            snackBar.remove();
          });
        }
        if (state is BMICalculateState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => BlocBloc(),
                child: ResultScreen(
                  usermodel: state.userModel,
                ),
              ),
            ),
          );
        }
        if (state is RegisterUserState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => BlocBloc(),
                child: const LoginScreen(),
              ),
            ),
          );
        }
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
        return keyboardDismisser(
            context: context,
            child: WillPopScope(
              onWillPop: () {
                return Future.value(true);
              },
              child: Scaffold(
                drawer: Drawer(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Column(
                      children: <Widget>[
                        DrawerHeader(
                          decoration: const BoxDecoration(color: Colors.grey),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    height: 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: _image == null
                                              ? const DecorationImage(
                                                  image: AssetImage(
                                                      'asset/images/bmi.jpeg'))
                                              : DecorationImage(
                                                  image: FileImage(
                                                      File(_image!.path)))),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 30,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        onShowButtomSheet();
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${_auth.currentUser?.email}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(children: <Widget>[
                            ListTile(
                              title: const Text('History'),
                              leading: const Icon(Icons.history),
                              onTap: () {
                                transferdata.add(RecordedEvent());
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.logout),
                              title: const Text('Sign Out'),
                              onTap: () {
                                Navigator.pop(context);
                                Dialogs.materialDialog(
                                    barrierDismissible: true,
                                    color: Colors.white,
                                    title: 'Are you sure to Sign out?',
                                    lottieBuilder: Lottie.asset(
                                      'asset/images/logout.json',
                                      repeat: false,
                                      fit: BoxFit.contain,
                                    ),
                                    context: context,
                                    actions: [
                                      GestureDetector(
                                        onTap: () {
                                          transferdata.add(SignOutEvent());
                                        },
                                        child: Container(
                                          height: 40,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.red,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Sign Out',
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
                            ),
                          ]),
                        ),
                        const Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '@Copyright R@ Foogy',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                appBar: AppBar(
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                          size: 25, // Changing Drawer Icon Size
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      );
                    },
                  ),
                  elevation: 0,
                  title: InkWell(
                    onTap: () {
                      if (_image != null) {
                        final snackBar = AnimatedSnackBar.material(
                          'This a snackbar with info type and a very very very long text',
                          type: AnimatedSnackBarType.info,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                          desktopSnackBarPosition:
                              DesktopSnackBarPosition.topCenter,
                          snackBarStrategy: RemoveSnackBarStrategy(),
                        );
                        snackBar.show(context);

                        Future.delayed(const Duration(seconds: 2), () {
                          snackBar.remove();
                        });
                      }
                    },
                    child: const Text(
                      'BMI Calculator',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                ),
                body: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                if (!ismale) {
                                  ismale = true;
                                  gender = 'Malse';
                                  isfemale = false;
                                }
                                setState(() {});
                              },
                              child: userWidget(Icons.male, ismale)),
                          InkWell(
                              onTap: () {
                                if (!isfemale) {
                                  isfemale = true;
                                  gender = 'Female';
                                  ismale = false;
                                  debugPrint(gender);
                                }
                                setState(() {});
                              },
                              child: userWidget(Icons.female, isfemale))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Stack(
                        children: [
                          // SpinBox(
                          //   value: 10,
                          //   onChanged: (value) {
                          //     age = value;
                          //     debugPrint('===============$age');
                          //   },
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(8)),
                          //     labelText: 'Age',
                          //     labelStyle: const TextStyle(
                          //       fontWeight: FontWeight.w800,
                          //       fontSize: 18,
                          //     ),
                          //   ),
                          // ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 150,
                              height: 60,
                              color: Colors.transparent,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Height(in cm)',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                          child: Text('${height.toStringAsFixed(0)} cm',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black))),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.2, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: RulerPicker(
                          controller: _rulerPickerController!,
                          onBuildRulerScaleText: (index, value) {
                            return value.toInt().toString();
                          },
                          ranges: ranges,
                          onValueChanged: (value) {
                            setState(() {
                              height = value - 4;
                              validation();
                              debugPrint('==============$height');
                            });
                          },
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          rulerScaleTextStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                          rulerMarginTop: 1,
                          // marker: Container(
                          //     width: 8,
                          //     height: 50,
                          //     decoration: BoxDecoration(color: Colors.red.withAlpha(100), borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Weight(in kg)',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      Expanded(
                        child: Center(
                          child: CircularSlider(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(-10, -10),
                                        color: Colors.white,
                                        blurRadius: 20,
                                        spreadRadius: 1),
                                  ]),
                              maxValue: 100,
                              color: Colors.white,
                              onDrag: (int value) {
                                setState(() {
                                  weight = double.parse(value.toString());
                                  validation();
                                });
                                debugPrint(value.toString());
                              },
                              radius: 95,
                              sliderColor: HexColor('#35D2E9'),
                              unSelectedColor: Colors.grey,
                              child: Text(
                                '$weight',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: validation() == true
                            ? () {
                                var userModel = UserModel(
                                    age: age,
                                    gender: gender,
                                    weight: weight,
                                    height: height,
                                    result: 0);
                                transferdata.add(BMICalculatorEvent(userModel));
                              }
                            : () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: isValidate
                                    ? HexColor('#35D2E9')
                                    : Colors.grey),
                            child: const Center(
                                child: Text(
                              'Calculate your BIM',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  bool isValidate = false;
  bool validation() {
    isValidate = height != 0 && weight != 0 && gender != '' && age != 0;
    return isValidate;
  }

  String downloadUrl = '';

  Widget keyboardDismisser({BuildContext? context, Widget? child}) {
    final gesture = GestureDetector(
      onTap: () {
        FocusScope.of(context!).requestFocus(FocusNode());
        validation();
      },
      child: child,
    );
    return gesture;
  }

  Widget userWidget(IconData url, isClick) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: HexColor('#F7F2EE'),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 2, color: isClick ? HexColor('#35D2E9') : Colors.white),
          boxShadow: const [BoxShadow(blurRadius: 3, color: Colors.grey)]),
      child: Icon(
        url,
        size: 70,
        color: isClick ? HexColor('#35D2E9') : Colors.grey,
      ),
    );
  }

  var snackBar = AnimatedSnackBar.material(
    'This a snackbar with info type and a very very very long text',
    type: AnimatedSnackBarType.info,
    mobileSnackBarPosition: MobileSnackBarPosition.top,
    desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    snackBarStrategy: RemoveSnackBarStrategy(),
  );

  Future getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  // Future<String> uploadImage(File imageFile, String filename) async {
  //   Reference storageReference = FirebaseStorage.instance.ref().child('file/$filename');
  //   UploadTask uploadTask = storageReference.putFile(imageFile);

  //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => transferdata.add(LoadingEvent()));
  //   String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //   print(downloadUrl);
  //   return downloadUrl;
  // }

  double toDouble(String value) {
    if (value.isEmpty) return 0;

    return double.tryParse(value) ?? 0;
  }

  Future onShowButtomSheet() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      getImageFromGallery();
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.withOpacity(0.2)),
                      child: const Center(
                          child: Text('Select Image From Gallery',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600))),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.withOpacity(0.2)),
                    child: const Center(
                        child: Text(
                      'Cancel',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    )),
                  )
                ],
              ),
            ),
          );
        });
  }
}
