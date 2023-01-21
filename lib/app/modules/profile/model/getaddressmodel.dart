class GetAddressModel {
  String? id;
  String? customerId;
  String? name;
  String? gender;
  String? dob;
  String? age;
  String? mobileNo;
  String? whatsapp;
  String? email;
  String? googleMap;
  String? googleLat;
  String? googleLng;
  String? address;
  String? country;
  String? state;
  String? city;
  String? pincode;
  String? countryName;
  String? stateName;
  String? addedDate;

  GetAddressModel(
      {this.id = "",
      this.customerId = "",
      this.name = "",
      this.gender = "",
      this.dob = "",
      this.age = "",
      this.mobileNo = "",
      this.whatsapp = "",
      this.email = "",
      this.googleMap = "",
      this.googleLat = "",
      this.googleLng = "",
      this.address = "",
      this.country = "",
      this.state = "",
      this.city = "",
      this.pincode = "",
      this.countryName = "",
      this.stateName = "",
      this.addedDate = ""});

  GetAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    name = json['name'];
    gender = json['gender'];
    dob = json['dob'];
    age = json['age'];
    mobileNo = json['mobile_no'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    googleMap = json['google_map'];
    googleLat = json['google_lat'];
    googleLng = json['google_lng'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    addedDate = json['added_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['name'] = name;
    data['gender'] = gender;
    data['dob'] = dob;
    data['age'] = age;
    data['mobile_no'] = mobileNo;
    data['whatsapp'] = whatsapp;
    data['email'] = email;
    data['google_map'] = googleMap;
    data['google_lat'] = googleLat;
    data['google_lng'] = googleLng;
    data['address'] = address;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['pincode'] = pincode;
    data['country_name'] = countryName;
    data['state_name'] = stateName;
    data['added_date'] = addedDate;
    return data;
  }
}
