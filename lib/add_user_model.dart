class AddUserModel {
  String id;
  String name;
  String email;
  String password;

  AddUserModel(
      {this.id = "",
        required this.name,
        
        required this.email,
      required this.password});
  AddUserModel.fromJson(Map<String, dynamic> json)
      : this(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      id: json['id']);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "id": id,
    };
  }
}
