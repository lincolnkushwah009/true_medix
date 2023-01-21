class UpdateProfileModel {
  String? id;
  String? name;
  String? password;
  String? profileImg;

  UpdateProfileModel({this.id, this.name, this.password, this.profileImg});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
    profileImg = json['profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['password'] = password;
    data['profile_img'] = profileImg;
    return data;
  }
}
