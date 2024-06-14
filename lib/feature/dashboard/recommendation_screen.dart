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
import 'package:online/feature/login/login_screen.dart';
import 'package:online/feature/util/app_connection.dart';
import 'package:online/model/food_model.dart';
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

List<FoodModel> listItem = [];

class HomeWidgetComponent extends StatefulWidget {
  final String status;
  const HomeWidgetComponent({super.key, required this.status});

  @override
  State<HomeWidgetComponent> createState() => _HomeWidgetComponentState();
}

class _HomeWidgetComponentState extends State<HomeWidgetComponent> {
  @override
  void initState() {
    super.initState();
    fetchFoodItems();
  }

  Future<List<FoodModel>> fetchFoodItems() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(widget.status).get();
      List<DocumentSnapshot> documents = querySnapshot.docs;
      listItem = documents.map((doc) {
        return FoodModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      debugPrint(listItem[1].title);
      return listItem;
    } catch (e) {
      print("Error fetching food items: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection(widget.status).get(),
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
              return GestureDetector(
                onTap: () {
                  if (widget.status != 'food') {
                    final foodModel = FoodModel(
                      image: data['image'],
                      ingredients: data['ingredients'],
                      description: data['description'],
                      nutrition: data['nutrition'],
                      title: data['title'],
                      status: widget.status,
                      price: data['price'],
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoodDetailScreen(
                                  foodModel: foodModel,
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
              );
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
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
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
          height: 10,
        ),
      ],
    ),
  );
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    filteredItems = listItem;
  }

  final TextEditingController _controller = TextEditingController();
  List<FoodModel> filteredItems = [];
  void filterSearchResults({required String query}) {
    setState(() {
      filteredItems = listItem
          .where(
              (item) => item.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Search Screen"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.search,
                  size: 25,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Search food',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    onChanged: (value) {
                      filterSearchResults(query: value);
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: filteredItems.isEmpty
                  ? List.generate(
                      listItem.length,
                      (index) {
                        final image = listItem[index].image;
                        return _customFoodContainer(
                            image: image ?? '',
                            title: listItem[index].title ?? '',
                            subitle: '');
                      },
                    )
                  : List.generate(
                      filteredItems.length,
                      (index) {
                        final image = filteredItems[index].image;
                        return _customFoodContainer(
                            image: image ?? '',
                            title: filteredItems[index].title ?? '',
                            subitle: '');
                      },
                    ),
            ),
          ))
        ],
      ),
    );
  }
}

Widget _customFoodContainer(
    {required String image, required String title, required String subitle}) {
  return Container(
    margin: const EdgeInsets.all(12),
    width: double.infinity,
    height: 120,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2), // Shadow color
          blurRadius: 10.0, // Blur radius of the shadow (spread)
          offset: const Offset(5.0, 5.0), // Displacement of the shadow (x, y)
          spreadRadius:
              2.0, // Optional: Extends the shadow beyond the offset (optional)
        )
      ],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        const SizedBox(
          width: 12,
        ),
        Container(
          width: 120,
          height: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 200,
              child: Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.5)),
              ),
            ),
            Text(
              subitle,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ],
        )
      ],
    ),
  );
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
