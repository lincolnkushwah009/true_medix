// To parse this JSON data, do
//
//     final orderResponseModel = orderResponseModelFromJson(jsonString);

import 'dart:convert';

OrderResponseModel orderResponseModelFromJson(String str) =>
    OrderResponseModel.fromJson(json.decode(str));

String orderResponseModelToJson(OrderResponseModel data) =>
    json.encode(data.toJson());

class OrderResponseModel {
  OrderResponseModel({
    required this.order,
    required this.reportFiles,
    required this.payments,
  });

  Order order;
  List<dynamic> reportFiles;
  List<Payment> payments;

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderResponseModel(
        order: Order.fromJson(json["order"]),
        reportFiles: List<dynamic>.from(json["report_files"].map((x) => x)),
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "report_files": List<dynamic>.from(reportFiles.map((x) => x)),
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    required this.id,
    this.apiBillid,
    this.apiPatientId,
    required this.orderNumber,
    required this.orderedOn,
    required this.scheduledOn,
    required this.status,
    this.customCharges,
    required this.tax,
    required this.subtotal,
    required this.couponDiscount,
    required this.customDiscount,
    required this.total,
    required this.dueAmount,
    required this.paidAmount,
    required this.totalProducts,
    required this.customerId,
    required this.name,
    required this.mobileNo,
    required this.email,
    required this.billName,
    required this.billDob,
    required this.billAge,
    required this.billGender,
    required this.billMobileNo,
    required this.billEmail,
    required this.billAddress,
    required this.billCity,
    required this.billZip,
    required this.billZone,
    required this.billZoneId,
    required this.billCountry,
    required this.billCountryId,
    required this.googleMap,
    required this.googleLat,
    required this.googleLng,
    required this.orderedBy,
    required this.phleboId,
    this.updatedOn,
    required this.coupon,
    required this.whatsapp,
    required this.contents,
  });

  String id;
  dynamic apiBillid;
  dynamic apiPatientId;
  String orderNumber;
  DateTime orderedOn;
  DateTime scheduledOn;
  String status;
  dynamic customCharges;
  String tax;
  String subtotal;
  String couponDiscount;
  String customDiscount;
  String total;
  String dueAmount;
  String paidAmount;
  String totalProducts;
  String customerId;
  String name;
  String mobileNo;
  String email;
  String billName;
  DateTime billDob;
  String billAge;
  String billGender;
  String billMobileNo;
  String billEmail;
  String billAddress;
  String billCity;
  String billZip;
  String billZone;
  String billZoneId;
  String billCountry;
  String billCountryId;
  String googleMap;
  String googleLat;
  String googleLng;
  String orderedBy;
  String phleboId;
  dynamic updatedOn;
  String coupon;
  String whatsapp;
  List<Content> contents;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        apiBillid: json["api_billid"],
        apiPatientId: json["api_patientId"],
        orderNumber: json["order_number"],
        orderedOn: DateTime.parse(json["ordered_on"]),
        scheduledOn: DateTime.parse(json["scheduled_on"]),
        status: json["status"],
        customCharges: json["custom_charges"],
        tax: json["tax"],
        subtotal: json["subtotal"],
        couponDiscount: json["coupon_discount"],
        customDiscount: json["custom_discount"],
        total: json["total"],
        dueAmount: json["due_amount"],
        paidAmount: json["paid_amount"],
        totalProducts: json["total_products"],
        customerId: json["customer_id"],
        name: json["name"],
        mobileNo: json["mobile_no"],
        email: json["email"],
        billName: json["bill_name"],
        billDob: DateTime.parse(json["bill_dob"]),
        billAge: json["bill_age"],
        billGender: json["bill_gender"],
        billMobileNo: json["bill_mobile_no"],
        billEmail: json["bill_email"],
        billAddress: json["bill_address"],
        billCity: json["bill_city"],
        billZip: json["bill_zip"],
        billZone: json["bill_zone"],
        billZoneId: json["bill_zone_id"],
        billCountry: json["bill_country"],
        billCountryId: json["bill_country_id"],
        googleMap: json["google_map"],
        googleLat: json["google_lat"],
        googleLng: json["google_lng"],
        orderedBy: json["ordered_by"],
        phleboId: json["phlebo_id"],
        updatedOn: json["updated_on"],
        coupon: json["coupon"],
        whatsapp: json["whatsapp"],
        contents: List<Content>.from(
            json["contents"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "api_billid": apiBillid,
        "api_patientId": apiPatientId,
        "order_number": orderNumber,
        "ordered_on": orderedOn.toIso8601String(),
        "scheduled_on": scheduledOn.toIso8601String(),
        "status": status,
        "custom_charges": customCharges,
        "tax": tax,
        "subtotal": subtotal,
        "coupon_discount": couponDiscount,
        "custom_discount": customDiscount,
        "total": total,
        "due_amount": dueAmount,
        "paid_amount": paidAmount,
        "total_products": totalProducts,
        "customer_id": customerId,
        "name": name,
        "mobile_no": mobileNo,
        "email": email,
        "bill_name": billName,
        "bill_dob":
            "${billDob.year.toString().padLeft(4, '0')}-${billDob.month.toString().padLeft(2, '0')}-${billDob.day.toString().padLeft(2, '0')}",
        "bill_age": billAge,
        "bill_gender": billGender,
        "bill_mobile_no": billMobileNo,
        "bill_email": billEmail,
        "bill_address": billAddress,
        "bill_city": billCity,
        "bill_zip": billZip,
        "bill_zone": billZone,
        "bill_zone_id": billZoneId,
        "bill_country": billCountry,
        "bill_country_id": billCountryId,
        "google_map": googleMap,
        "google_lat": googleLat,
        "google_lng": googleLng,
        "ordered_by": orderedBy,
        "phlebo_id": phleboId,
        "updated_on": updatedOn,
        "coupon": coupon,
        "whatsapp": whatsapp,
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.slug,
    required this.appDate,
    required this.qty,
    required this.itmSubtotal,
    required this.contents,
    required this.bundleProducts,
    required this.itmStatus,
    required this.adminId,
    required this.updatedDate,
  });

  String id;
  String orderId;
  String productId;
  String productName;
  String slug;
  DateTime appDate;
  String qty;
  String itmSubtotal;
  String contents;
  String bundleProducts;
  String itmStatus;
  String adminId;
  DateTime updatedDate;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        slug: json["slug"],
        appDate: DateTime.parse(json["app_date"]),
        qty: json["qty"],
        itmSubtotal: json["itm_subtotal"],
        contents: json["contents"],
        bundleProducts: json["bundle_products"],
        itmStatus: json["itm_status"],
        adminId: json["admin_id"],
        updatedDate: DateTime.parse(json["updated_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "product_name": productName,
        "slug": slug,
        "app_date": appDate.toIso8601String(),
        "qty": qty,
        "itm_subtotal": itmSubtotal,
        "contents": contents,
        "bundle_products": bundleProducts,
        "itm_status": itmStatus,
        "admin_id": adminId,
        "updated_date": updatedDate.toIso8601String(),
      };
}

class Payment {
  Payment({
    required this.id,
    required this.orderId,
    required this.orderNumber,
    required this.type,
    required this.mode,
    required this.payStatus,
    required this.amount,
    required this.pgPaymentId,
    required this.pgOrderId,
    this.response,
    required this.gateway,
    required this.adminId,
    required this.createdOn,
    this.updatedOn,
  });

  String id;
  String orderId;
  String orderNumber;
  String type;
  String mode;
  String payStatus;
  String amount;
  String pgPaymentId;
  String pgOrderId;
  dynamic response;
  String gateway;
  String adminId;
  DateTime createdOn;
  dynamic updatedOn;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        orderId: json["order_id"],
        orderNumber: json["order_number"],
        type: json["type"],
        mode: json["mode"],
        payStatus: json["pay_status"],
        amount: json["amount"],
        pgPaymentId: json["pg_payment_id"],
        pgOrderId: json["pg_order_id"],
        response: json["response"],
        gateway: json["gateway"],
        adminId: json["admin_id"],
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "order_number": orderNumber,
        "type": type,
        "mode": mode,
        "pay_status": payStatus,
        "amount": amount,
        "pg_payment_id": pgPaymentId,
        "pg_order_id": pgOrderId,
        "response": response,
        "gateway": gateway,
        "admin_id": adminId,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn,
      };
}
