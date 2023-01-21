class OrderModel {
  String? id;
  String? apiBillid;
  String? apiPatientId;
  String? orderNumber;
  String? orderedOn;
  String? scheduledOn;
  String? status;
  String? customCharges;
  String? tax;
  String? subtotal;
  String? couponDiscount;
  String? total;
  String? dueAmount;
  String? paidAmount;
  String? totalProducts;
  String? customerId;
  String? name;
  String? mobileNo;
  String? email;
  String? billName;
  String? billDob;
  String? billAge;
  String? billGender;
  String? billMobileNo;
  String? billEmail;
  String? billAddress;
  String? billCity;
  String? billZip;
  String? billZone;
  String? billZoneId;
  String? billCountry;
  String? billCountryId;
  String? googleMap;
  String? googleLat;
  String? googleLng;
  String? orderedBy;
  String? phleboId;
  String? updatedOn;
  String? coupon;
  String? whatsapp;

  OrderModel(
      {this.id,
      this.apiBillid,
      this.apiPatientId,
      this.orderNumber,
      this.orderedOn,
      this.scheduledOn,
      this.status,
      this.customCharges,
      this.tax,
      this.subtotal,
      this.couponDiscount,
      this.total,
      this.dueAmount,
      this.paidAmount,
      this.totalProducts,
      this.customerId,
      this.name,
      this.mobileNo,
      this.email,
      this.billName,
      this.billDob,
      this.billAge,
      this.billGender,
      this.billMobileNo,
      this.billEmail,
      this.billAddress,
      this.billCity,
      this.billZip,
      this.billZone,
      this.billZoneId,
      this.billCountry,
      this.billCountryId,
      this.googleMap,
      this.googleLat,
      this.googleLng,
      this.orderedBy,
      this.phleboId,
      this.updatedOn,
      this.coupon,
      this.whatsapp});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    apiBillid = json['api_billid'];
    apiPatientId = json['api_patientId'];
    orderNumber = json['order_number'];
    orderedOn = json['ordered_on'];
    scheduledOn = json['scheduled_on'];
    status = json['status'];
    customCharges = json['custom_charges'];
    tax = json['tax'];
    subtotal = json['subtotal'];
    couponDiscount = json['coupon_discount'];
    total = json['total'];
    dueAmount = json['due_amount'];
    paidAmount = json['paid_amount'];
    totalProducts = json['total_products'];
    customerId = json['customer_id'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    billName = json['bill_name'];
    billDob = json['bill_dob'];
    billAge = json['bill_age'];
    billGender = json['bill_gender'];
    billMobileNo = json['bill_mobile_no'];
    billEmail = json['bill_email'];
    billAddress = json['bill_address'];
    billCity = json['bill_city'];
    billZip = json['bill_zip'];
    billZone = json['bill_zone'];
    billZoneId = json['bill_zone_id'];
    billCountry = json['bill_country'];
    billCountryId = json['bill_country_id'];
    googleMap = json['google_map'];
    googleLat = json['google_lat'];
    googleLng = json['google_lng'];
    orderedBy = json['ordered_by'];
    phleboId = json['phlebo_id'];
    updatedOn = json['updated_on'];
    coupon = json['coupon'];
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['api_billid'] = apiBillid;
    data['api_patientId'] = apiPatientId;
    data['order_number'] = orderNumber;
    data['ordered_on'] = orderedOn;
    data['scheduled_on'] = scheduledOn;
    data['status'] = status;
    data['custom_charges'] = customCharges;
    data['tax'] = tax;
    data['subtotal'] = subtotal;
    data['coupon_discount'] = couponDiscount;
    data['total'] = total;
    data['due_amount'] = dueAmount;
    data['paid_amount'] = paidAmount;
    data['total_products'] = totalProducts;
    data['customer_id'] = customerId;
    data['name'] = name;
    data['mobile_no'] = mobileNo;
    data['email'] = email;
    data['bill_name'] = billName;
    data['bill_dob'] = billDob;
    data['bill_age'] = billAge;
    data['bill_gender'] = billGender;
    data['bill_mobile_no'] = billMobileNo;
    data['bill_email'] = billEmail;
    data['bill_address'] = billAddress;
    data['bill_city'] = billCity;
    data['bill_zip'] = billZip;
    data['bill_zone'] = billZone;
    data['bill_zone_id'] = billZoneId;
    data['bill_country'] = billCountry;
    data['bill_country_id'] = billCountryId;
    data['google_map'] = googleMap;
    data['google_lat'] = googleLat;
    data['google_lng'] = googleLng;
    data['ordered_by'] = orderedBy;
    data['phlebo_id'] = phleboId;
    data['updated_on'] = updatedOn;
    data['coupon'] = coupon;
    data['whatsapp'] = whatsapp;
    return data;
  }
}
