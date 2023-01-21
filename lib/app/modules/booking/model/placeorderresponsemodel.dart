class PlaceOrderResponseModel {
  String? orderId;
  String? message;

  PlaceOrderResponseModel({this.orderId, this.message});

  PlaceOrderResponseModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['message'] = message;
    return data;
  }
}
