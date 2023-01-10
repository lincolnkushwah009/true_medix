class AddressModel {
  String? name;
  String? customerId;
  String? age;
  String? gender;
  String? dob;
  String? mobileNo;
  String? email;
  String? googleMap;
  String? googleLat;
  String? googleLng;
  String? address;
  String? country;
  String? state;
  String? city;
  String? pincode;

  AddressModel(
      {this.name,
      this.customerId,
      this.age,
      this.gender,
      this.dob,
      this.mobileNo,
      this.email,
      this.googleMap,
      this.googleLat,
      this.googleLng,
      this.address,
      this.country,
      this.state,
      this.city,
      this.pincode});

  AddressModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerId = json['customer_id'];
    age = json['age'];
    gender = json['gender'];
    dob = json['dob'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    googleMap = json['google_map'];
    googleLat = json['google_lat'];
    googleLng = json['google_lng'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['customer_id'] = customerId;
    data['age'] = age;
    data['gender'] = gender;
    data['dob'] = dob;
    data['mobile_no'] = mobileNo;
    data['email'] = email;
    data['google_map'] = googleMap;
    data['google_lat'] = googleLat;
    data['google_lng'] = googleLng;
    data['address'] = address;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['pincode'] = pincode;
    return data;
  }
}
