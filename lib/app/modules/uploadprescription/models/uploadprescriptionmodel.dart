class UploadPrescriptionModel {
  String? name;
  String? mobile;
  String? prescription;

  UploadPrescriptionModel({this.name, this.mobile, this.prescription});

  UploadPrescriptionModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    prescription = json['prescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['mobile'] = mobile;
    data['prescription'] = prescription;
    return data;
  }
}
