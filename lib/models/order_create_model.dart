class OrderCreate {
  bool? success;
  String? message;
  Data? data;

  OrderCreate({this.success, this.message, this.data});

  OrderCreate.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  num? gst;
  String? amountWithoutTax;
  num? amount;
  String? orderId;

  Data({this.gst, this.amountWithoutTax, this.amount, this.orderId});

  Data.fromJson(Map<String, dynamic> json) {
    gst = json['gst'];
    amountWithoutTax = json['amount_without_tax'];
    amount = json['amount'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gst'] = this.gst;
    data['amount_without_tax'] = this.amountWithoutTax;
    data['amount'] = this.amount;
    data['order_id'] = this.orderId;
    return data;
  }
}
