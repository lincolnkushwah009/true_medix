class RegisterModel {
  String? name;
  String? email;
  String? mobileNo;
  String? password;

  RegisterModel({this.name, this.email, this.mobileNo, this.password});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['password'] = password;
    return data;
  }
}
