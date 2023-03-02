class HomeProductModel {
  List<Records>? records;
  String? totalRecords;
  String? totalPages;
  String? currentPage;

  HomeProductModel(
      {this.records, this.totalRecords, this.totalPages, this.currentPage});

  HomeProductModel.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(Records.fromJson(v));
      });
    }
    totalRecords = json['total_records'].toString();
    totalPages = json['total_pages'].toString();
    currentPage = json['current_page'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    data['total_records'] = totalRecords;
    data['total_pages'] = totalPages;
    data['current_page'] = currentPage;
    return data;
  }
}

class Records {
  String? id;
  String? name;
  String? description;
  String? price;
  String? saleprice;
  String? image;
  String? apiTestID;
  String? apiTestCategory;
  String? apiTestCode;
  String? apiDictionaryId;
  String? apiDepartmentName;
  String? apiTestDescription;
  String? relatedBundleIds;
  List<RelatedBundleItems>? relatedBundleItems;
  Ratings? ratings;

  Records(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.saleprice,
      this.image,
      this.apiTestID,
      this.apiTestCategory,
      this.apiTestCode,
      this.apiDictionaryId,
      this.apiDepartmentName,
      this.apiTestDescription,
      this.relatedBundleIds,
      this.relatedBundleItems,
      this.ratings});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    saleprice = json['saleprice'];
    image = json['image'];
    apiTestID = json['api_testID'];
    apiTestCategory = json['api_testCategory'];
    apiTestCode = json['api_testCode'];
    apiDictionaryId = json['api_dictionaryId'];
    apiDepartmentName = json['api_departmentName'];
    apiTestDescription = json['api_testDescription'];
    relatedBundleIds = json['related_bundle_ids'];
    if (json['related_bundle_items'] != null) {
      relatedBundleItems = <RelatedBundleItems>[];
      json['related_bundle_items'].forEach((v) {
        relatedBundleItems!.add(RelatedBundleItems.fromJson(v));
      });
    }
    ratings =
        json['ratings'] != null ? Ratings.fromJson(json['ratings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['saleprice'] = saleprice;
    data['image'] = image;
    data['api_testID'] = apiTestID;
    data['api_testCategory'] = apiTestCategory;
    data['api_testCode'] = apiTestCode;
    data['api_dictionaryId'] = apiDictionaryId;
    data['api_departmentName'] = apiDepartmentName;
    data['api_testDescription'] = apiTestDescription;
    data['related_bundle_ids'] = relatedBundleIds;
    if (relatedBundleItems != null) {
      data['related_bundle_items'] =
          relatedBundleItems!.map((v) => v.toJson()).toList();
    }
    if (ratings != null) {
      data['ratings'] = ratings!.toJson();
    }
    return data;
  }
}

class RelatedBundleItems {
  String? id;
  String? name;
  String? price;
  String? saleprice;
  String? apiTestID;
  String? apiTestCategory;
  String? apiTestCode;
  String? apiTestDescription;

  RelatedBundleItems(
      {this.id,
      this.name,
      this.price,
      this.saleprice,
      this.apiTestID,
      this.apiTestCategory,
      this.apiTestCode,
      this.apiTestDescription});

  RelatedBundleItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    saleprice = json['saleprice'];
    apiTestID = json['api_testID'];
    apiTestCategory = json['api_testCategory'];
    apiTestCode = json['api_testCode'];
    apiTestDescription = json['api_testDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['saleprice'] = saleprice;
    data['api_testID'] = apiTestID;
    data['api_testCategory'] = apiTestCategory;
    data['api_testCode'] = apiTestCode;
    data['api_testDescription'] = apiTestDescription;
    return data;
  }
}

class Ratings {
  String? total;
  int? roundRating;
  int? avgRating;

  Ratings({this.total, this.roundRating, this.avgRating});

  Ratings.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    roundRating = json['round_rating'];
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['round_rating'] = roundRating;
    data['avg_rating'] = avgRating;
    return data;
  }
}