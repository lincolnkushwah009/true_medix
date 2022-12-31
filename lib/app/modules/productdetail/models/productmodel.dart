// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.saleprice,
    this.image,
    this.apiTestId,
    this.apiTestCategory,
    this.apiTestCode,
    this.apiDictionaryId,
    this.apiDepartmentName,
  });

  String? id;
  String? name;
  dynamic description;
  String? price;
  String? saleprice;
  String? image;
  String? apiTestId;
  String? apiTestCategory;
  String? apiTestCode;
  String? apiDictionaryId;
  String? apiDepartmentName;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        saleprice: json["saleprice"],
        image: json["image"],
        apiTestId: json["api_testID"],
        apiTestCategory: json["api_testCategory"],
        apiTestCode: json["api_testCode"],
        apiDictionaryId: json["api_dictionaryId"],
        apiDepartmentName: json["api_departmentName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "saleprice": saleprice,
        "image": image,
        "api_testID": apiTestId,
        "api_testCategory": apiTestCategory,
        "api_testCode": apiTestCode,
        "api_dictionaryId": apiDictionaryId,
        "api_departmentName": apiDepartmentName,
      };
}
