import 'package:flutter/material.dart';
import 'package:online/feature/dashboard/food_detail.dart';
import 'package:online/feature/dashboard/purhcase_information.dart';
import 'package:online/model/food_model.dart';
import 'package:online/util/app_util.dart';

class PurchaseScreen extends StatefulWidget {
  final FoodModel foodModel;

  const PurchaseScreen({super.key, required this.foodModel});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  final List<dynamic> listOfInfo = [
    "Calories   1200 cals",
    "Carb   3g",
    "Protein   5g",
    "Fat   6g"
  ];
  late final String status;
  late int indexClicked;
  late List<dynamic> items = [];
  @override
  void initState() {
    super.initState();
    status = widget.foodModel.status ?? '';
    items = widget.foodModel.daily!['day1'];
    indexClicked = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.foodModel.image ?? '',
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Since most of the fasting window occurs while you are sleeping, this IF method might be a good choice for beginners.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: listOfInfo.map((info) {
                        return CustomBox(title: info, color: getColor(info));
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  PriceSection(
                    price: widget.foodModel.price ?? '',
                  ),
                  const SizedBox(height: 30),
                  PurchaseButton(
                    onTap: () {
                      debugPrint("ehh");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PuchaseInformationScreen(
                                  foodModel: widget.foodModel)));
                    },
                  ),
                  const Divider(thickness: 0.5),
                  const DailyFoodTitle(),
                  FoodSelectionRow(
                    onIndexChanged: (index) {
                      setState(() {
                        indexClicked = index;
                      });
                    },
                    selectedIndex: indexClicked,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GetDetailItem(
                    item: widget.foodModel.daily?['day$selectIndex'] ?? [],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(String title) {
    switch (title) {
      case "Carb   3g":
        return Colors.greenAccent;
      case "Protein   5g":
        return Colors.blue;
      case "Fat   6g":
        return Colors.amberAccent;
      default:
        return Colors.green;
    }
  }
}

class CustomBox extends StatelessWidget {
  final String title;
  final Color color;

  const CustomBox({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 33,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class PriceSection extends StatelessWidget {
  final String price;
  const PriceSection({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "1 Package: ",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: HexColor("#106D11"),
          ),
        ),
      ],
    );
  }
}

class PurchaseButton extends StatelessWidget {
  const PurchaseButton({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: HexColor("#4FC376"),
        ),
        child: const Center(
          child: Text(
            "Purchase",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class DailyFoodTitle extends StatelessWidget {
  const DailyFoodTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        "Daily Food: ",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}

int selectIndex = 0;
int changeNum(int num) {
  if (num == 0) return selectIndex = 1;
  if (num == 1) return selectIndex = 2;
  if (num == 2) return selectIndex = 3;
  return 0;
}

class FoodSelectionRow extends StatelessWidget {
  final Function(int) onIndexChanged;
  final int selectedIndex;

  const FoodSelectionRow({
    super.key,
    required this.onIndexChanged,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  onIndexChanged(index);
                  debugPrint(selectIndex.toString());
                  changeNum(index);
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Colors.greenAccent
                        : Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text("${index + 1}"),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class GetDetailItem extends StatefulWidget {
  final List<dynamic> item;
  const GetDetailItem({
    super.key,
    required this.item,
  });

  @override
  State<GetDetailItem> createState() => _GetDetailItemState();
}

class _GetDetailItemState extends State<GetDetailItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(widget.item.length, (index) {
          final image = widget.item[index]['image'];
          final detailFood = widget.item[index]['ingredients'];
          final nutrition = widget.item[index]['nutrition'];
          return GestureDetector(
            onTap: () {
              final foodModel = FoodModel(
                image: image,
                ingredients: detailFood,
                description: widget.item[index]['description'],
                nutrition: nutrition,
                title: widget.item[index]['title'],
                price: widget.item[index]['price'] ?? '',
                status: 'food',
              );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodDetailScreen(
                            foodModel: foodModel,
                          )));
            },
            child: customeWidgetFoodContainer(
                title: widget.item[index]['title'], image: image),
          );
        }),
      ),
    );
  }
}

Widget customeWidgetFoodContainer(
    {required String title, required String image}) {
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
      ],
    ),
  );
}
