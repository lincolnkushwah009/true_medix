class ProfileModel {
  String? id;
  String? name;
  String? email;
  String? mobileNo;
  String? profileImg;
  String? authId;

  ProfileModel(
      {this.id,
      this.name,
      this.email,
      this.mobileNo,
      this.profileImg,
      this.authId});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    profileImg = json['profile_img'];
    authId = json['auth_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['profile_img'] = profileImg;
    data['auth_id'] = authId;
    return data;
  }
}
