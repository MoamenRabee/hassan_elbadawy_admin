class AdminModel {
  String? email;
  String? password;

  AdminModel({
    required this.email,
    required this.password,
  });

  AdminModel.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    password = json["password"];
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
    };
  }
}


// Collection Name : Admins