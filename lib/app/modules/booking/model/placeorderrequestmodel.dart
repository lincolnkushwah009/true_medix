class PlaceOrderRequestModel {
  String? orderedOn;
  String? scheduledOn;
  String? tax;
  String? subtotal;
  String? couponDiscount;
  String? total;
  String? paidAmount;
  String? dueAmount;
  int? totalProducts;
  int? customerId;
  String? name;
  String? mobile;
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
  String? coupon;
  List<Items>? items;
  Payment? payment;

  PlaceOrderRequestModel(
      {this.orderedOn,
      this.scheduledOn,
      this.tax,
      this.subtotal,
      this.couponDiscount,
      this.total,
      this.paidAmount,
      this.dueAmount,
      this.totalProducts,
      this.customerId,
      this.name,
      this.mobile,
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
      this.coupon,
      this.items,
      this.payment});

  PlaceOrderRequestModel.fromJson(Map<String, dynamic> json) {
    orderedOn = json['ordered_on'];
    scheduledOn = json['scheduled_on'];
    tax = json['tax'];
    subtotal = json['subtotal'];
    couponDiscount = json['coupon_discount'];
    total = json['total'];
    paidAmount = json['paid_amount'];
    dueAmount = json['due_amount'];
    totalProducts = json['total_products'];
    customerId = json['customer_id'];
    name = json['name'];
    mobile = json['mobile'];
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
    coupon = json['coupon'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ordered_on'] = orderedOn;
    data['scheduled_on'] = scheduledOn;
    data['tax'] = tax;
    data['subtotal'] = subtotal;
    data['coupon_discount'] = couponDiscount;
    data['total'] = total;
    data['paid_amount'] = paidAmount;
    data['due_amount'] = dueAmount;
    data['total_products'] = totalProducts;
    data['customer_id'] = customerId;
    data['name'] = name;
    data['mobile'] = mobile;
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
    data['coupon'] = coupon;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    return data;
  }
}

class Items {
  String? productId;
  String? appDate;
  int? qty;
  String? amount;

  Items({this.productId, this.appDate, this.qty, this.amount});

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    appDate = json['app_date'];
    qty = json['qty'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['app_date'] = appDate;
    data['qty'] = qty;
    data['amount'] = amount;
    return data;
  }
}

class Payment {
  String? type;
  String? mode;
  String? amount;
  String? pgPaymentId;
  String? pgOrderId;

  Payment(
      {this.type, this.mode, this.amount, this.pgPaymentId, this.pgOrderId});

  Payment.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    mode = json['mode'];
    amount = json['amount'];
    pgPaymentId = json['pg_payment_id'];
    pgOrderId = json['pg_order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['mode'] = mode;
    data['amount'] = amount;
    data['pg_payment_id'] = pgPaymentId;
    data['pg_order_id'] = pgOrderId;
    return data;
  }
}
