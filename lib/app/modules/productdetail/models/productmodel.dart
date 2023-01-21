// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel? productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel? data) => json.encode(data!.toJson());

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
    this.apiTestDescription,
    this.relatedBundleIds,
    this.relatedBundleItems,
    this.ratings,
  });

  String? id;
  String? name;
  String? description;
  String? price;
  String? saleprice;
  String? image;
  String? apiTestId;
  String? apiTestCategory;
  String? apiTestCode;
  String? apiDictionaryId;
  String? apiDepartmentName;
  String? apiTestDescription;
  String? relatedBundleIds;
  List<RelatedBundleItem?>? relatedBundleItems;
  Ratings? ratings;

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
        apiTestDescription: json["api_testDescription"],
        relatedBundleIds: json["related_bundle_ids"],
        relatedBundleItems: json["related_bundle_items"] == null
            ? []
            : List<RelatedBundleItem?>.from(json["related_bundle_items"]!
                .map((x) => RelatedBundleItem.fromJson(x))),
        ratings: Ratings.fromJson(json["ratings"] ?? {}),
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
        "api_testDescription": apiTestDescription,
        "related_bundle_ids": relatedBundleIds,
        "related_bundle_items": relatedBundleItems == null
            ? []
            : List<dynamic>.from(relatedBundleItems!.map((x) => x!.toJson())),
        "ratings": ratings!.toJson(),
      };
}

class Ratings {
  Ratings({
    this.total,
    this.roundRating,
    this.avgRating,
  });

  String? total;
  int? roundRating;
  int? avgRating;

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        total: json["total"],
        roundRating: json["round_rating"],
        avgRating: json["avg_rating"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "round_rating": roundRating,
        "avg_rating": avgRating,
      };
}

class RelatedBundleItem {
  RelatedBundleItem({
    this.id,
    this.name,
    this.price,
    this.saleprice,
    this.apiTestId,
    this.apiTestCategory,
    this.apiTestCode,
    this.apiTestDescription,
  });

  String? id;
  String? name;
  String? price;
  String? saleprice;
  String? apiTestId;
  String? apiTestCategory;
  String? apiTestCode;
  String? apiTestDescription;

  factory RelatedBundleItem.fromJson(Map<String, dynamic> json) =>
      RelatedBundleItem(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        saleprice: json["saleprice"],
        apiTestId: json["api_testID"],
        apiTestCategory: json["api_testCategory"],
        apiTestCode: json["api_testCode"],
        apiTestDescription: json["api_testDescription"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "saleprice": saleprice,
        "api_testID": apiTestId,
        "api_testCategory": apiTestCategory,
        "api_testCode": apiTestCode,
        "api_testDescription": apiTestDescription,
      };
}
