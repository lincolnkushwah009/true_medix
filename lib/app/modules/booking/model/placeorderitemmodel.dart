class PlaceOrderItemModel {
  String? productId;
  String? appDate;
  int? qty;
  String? amount;

  PlaceOrderItemModel({this.productId, this.appDate, this.qty, this.amount});

  PlaceOrderItemModel.fromJson(Map<String, dynamic> json) {
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
