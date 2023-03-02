class CartModel {
  String? id;
  String? name;
  String? description;
  String? price;
  String? saleprice;
  String? image;
  String? apiTestID;
  String? apiTestCategory;
  String? apiDictionaryId;
  String? apiDepartmentName;
  String? apiTestDescription;
  String? relatedProducts;

  CartModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.saleprice,
      this.image,
      this.apiTestID,
      this.apiTestCategory,
      this.apiDictionaryId,
      this.apiDepartmentName,
      this.apiTestDescription,
      this.relatedProducts});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    saleprice = json['saleprice'];
    image = json['image'];
    apiTestID = json['api_testID'];
    apiTestCategory = json['api_testCategory'];
    apiDictionaryId = json['api_dictionaryId'];
    apiDepartmentName = json['api_departmentName'];
    apiTestDescription = json['api_testDescription'];
    relatedProducts = json['related_products'];
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
    data['api_dictionaryId'] = apiDictionaryId;
    data['api_departmentName'] = apiDepartmentName;
    data['api_testDescription'] = apiTestDescription;
    data['related_products'] = relatedProducts;
    return data;
  }
}
