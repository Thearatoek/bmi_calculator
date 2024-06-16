import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/model/food_model.dart';
import 'package:online/mybloc/bloc_bloc.dart';
import 'package:online/util/app_util.dart';

import 'checkout_screen.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodModel foodModel;
  const FoodDetailScreen({super.key, required this.foodModel});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  @override
  void initState() {
    debugPrint(widget.foodModel.status);
    super.initState();
  }

  double _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _descrease() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.network(
                  widget.foodModel.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 16,
                bottom: 12,
                child: Text(
                  widget.foodModel.title ?? '',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.foodModel.status != 'food')
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
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
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (() {
                                    _descrease();
                                  }),
                                  child: const Icon(
                                    Icons.remove_circle,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(_counter.toString()),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _incrementCounter();
                                    print("=========== $_counter");
                                  },
                                  child: const Icon(
                                    Icons.add_circle,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                            create: (context) => BlocBloc(),
                                            child: CheckOutScreen(
                                              foodModel: widget.foodModel,
                                              nubmerofUnit: _counter,
                                            )),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    width: 200,
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
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      widget.foodModel.description ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Ingredients",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        const SizedBox(
                          height: 15,
                        ),
                        ...List.generate(
                            widget.foodModel.ingredients?.length ?? 0, (index) {
                          final text = widget.foodModel.ingredients![index];
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.black,
                                      size: 4,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(text, overflow: TextOverflow.clip),
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
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
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Nutrition in serving",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        const SizedBox(
                          height: 15,
                        ),
                        ...List.generate(widget.foodModel.nutrition!.length,
                            (index) {
                          final text = widget.foodModel.nutrition![index];
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.black,
                                      size: 4,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(text),
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
