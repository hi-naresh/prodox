class UserModel {
  String id;
  String email;
  String? name;
  int? age;
  String? gender;
  String? goal;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.age,
    this.gender,
    this.goal,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'age': age,
      'gender': gender,
      'goal': goal,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      goal: json['goal'],
    );
  }
}
