class UserModel {
  double? age;
  double? weight;
  double? height;
  double? result;
  String? gender;

  UserModel({this.age, this.weight, this.height, this.result, this.gender});

  UserModel.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    weight = json['weight'];
    height = json['height'];
    result = json['result'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['age'] = age;
    data['weight'] = weight;
    data['height'] = height;
    data['result'] = result;
    data['gender'] = gender;
    return data;
  }
}
