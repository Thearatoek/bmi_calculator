class FoodModel {
  String? image;
  String? title;
  List<dynamic>? ingredients;
  String? description;
  String? price;
  String? status;
  List<dynamic>? nutrition;
  Map<String, dynamic>? daily;

  FoodModel(
      {this.image,
      this.title,
      this.ingredients,
      this.nutrition,
      this.status,
      this.price,
      this.daily,
      this.description});

  FoodModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    description = json['description'];
    ingredients = json['ingredients'] ?? [];
    nutrition = json['nutrition'] ?? [];
    status = json['status'] ?? '';
    price = json['price'] ?? '';
    daily = json['daily'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    return data;
  }
}
