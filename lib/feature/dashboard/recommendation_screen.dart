import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:online/feature/dashboard/exercise_screen.dart';
import 'package:online/feature/dashboard/food_detail.dart';
import 'package:online/feature/dashboard/puchase_screen.dart';
import 'package:online/feature/dashboard/purhcase_information.dart';
import 'package:online/feature/login/login_screen.dart';
import 'package:online/mybloc/bloc_bloc.dart';
import 'package:online/util/app_util.dart';

import '../../widget/profile_widget.dart';

class RecommendationScreen extends StatefulWidget {
  final String statusType;
  const RecommendationScreen({super.key, required this.statusType});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  int _selectedIndex = 0;
  @override
  void initState() {
    debugPrint(widget.statusType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeWidgetComponent(
        status: widget.statusType,
      ),
      const SearchScreen(),
      const ExerciseScreen(),
      const ProfileScreen(),
    ];
    return BlocConsumer<BlocBloc, BlocState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: HexColor("#4FC376"),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.work_outline),
                  label: 'Exercise',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              onTap: ((index) {
                setState(() {
                  _selectedIndex = index;
                });
              }),
              type: BottomNavigationBarType.fixed),
        );
      },
    );
  }
}

class HomeWidgetComponent extends StatelessWidget {
  final String status;
  const HomeWidgetComponent({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection(status).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;

              return Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      if (status != 'food') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FoodDetailScreen(
                                      image: data['image'],
                                      detailFood: data['ingredients'],
                                      description: data['description'],
                                      nutrition: data['nutrition'],
                                      title: data['title'],
                                      status: status,
                                      price: data['price'],
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PurchaseScreen(
                                      status: data['status'],
                                      title: data['title'],
                                      image: data['image'],
                                      daily: data['daily'],
                                      subitle: data['subtile'],
                                      price: data['price'],
                                    )));
                      }
                    },
                    child: customeWidgetFoodContainer(
                        subtitle: data['subtile'],
                        title: data['title'],
                        image: data['image']),
                  ));
            },
          );
        }
      },
    );
  }
}

Widget customeWidgetFoodContainer(
    {required String title, String? subtitle, required String image}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 230,
          decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle ?? "",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.5)),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Please search');
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _getCurrentUser();
    debugPrint(_user.toString());
    super.initState();
  }

  User? _user;
  void _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocBloc>(context);
    return BlocListener<BlocBloc, BlocState>(listener: (context, state) {
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
    }, child: BlocBuilder<BlocBloc, BlocState>(builder: ((context, state) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage('asset/images/bmi.jpeg'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              /// -- BUTTON

              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                title: "Name",
                icon: LineAwesomeIcons.user,
                onPress: () {},
                subitle: '${_user!.email?.replaceAll('@gmail.com', '')}',
              ),
              ProfileMenuWidget(
                title: "Username",
                icon: LineAwesomeIcons.user_check,
                onPress: () {},
                subitle: '@${_user!.email?.replaceAll('@gmail.com', '')}',
              ),
              ProfileMenuWidget(
                title: "Email",
                icon: LineAwesomeIcons.mail_bulk,
                onPress: () {},
                subitle: '${_user!.email}',
              ),
              const Divider(),
              const SizedBox(height: 10),

              ProfileMenuWidget(
                title: "Logout",
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  Dialogs.materialDialog(
                      barrierDismissible: true,
                      color: Colors.white,
                      titleAlign: TextAlign.center,
                      title: 'Are you sure to log out?',
                      lottieBuilder: Lottie.asset(
                        'asset/images/logout.json',
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
                          onTap: () async {
                            bloc.add(SignOutEvent());
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
                                'Log out',
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
                subitle: '',
              ),
            ],
          ),
        ),
      );
    })));
  }
}
