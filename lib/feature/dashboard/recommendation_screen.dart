import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online/feature/dashboard/puchase_screen.dart';
import 'package:online/util/app_util.dart';

class RecommendationScreen extends StatefulWidget {
  final String statusType;
  const RecommendationScreen(this.statusType, {super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 1) {
      const PuchaseScreen(image: "");
    }
  }

  CollectionReference foodCollection =
      FirebaseFirestore.instance.collection('food');
  final _auth = FirebaseAuth.instance;
  Future<void> addFoodFireStore() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await foodCollection.add({
        "title": "KETO",
        "subtile":
            "The ketogenic (keto) diet is a high-fat, very low-carbohydrate, and moderate-protein diet.",
        "image":
            "https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=861,h=600,fit=crop/AwvL7WbqRLHXekVz/keto-diet-foods-1-ALpX60x9bkIGbMow.webp"
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('food').get(),
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
                        padding: const EdgeInsets.only(top: 10),
                        child: _selectedIndex != 1
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PuchaseScreen(
                                              image: data['image'])));
                                },
                                child: customeWidgetFoodContainer(
                                    image: data['image'],
                                    subtitle: data['subtile'],
                                    title: data['title']))
                            : _widgetOptions.elementAt(_selectedIndex));
                  });
            }
          }),
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget customeWidgetFoodContainer(
    {required String title, required String subtitle, required String image}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.5)),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 230,
          decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
        )
      ],
    ),
  );
}

const List<Widget> _widgetOptions = <Widget>[];
