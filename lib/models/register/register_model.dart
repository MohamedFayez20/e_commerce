class RegisterModel {
  late bool status;
  late String message;
  RegisterData? data;
  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? RegisterData.fromJson(json['data']) : null;
  }
}

class RegisterData {
  String? name;
  String? phone;
  String? email;
  String? password;
  RegisterData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }
}
