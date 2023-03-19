class PaymentGatewayModel {
  bool? success;
  String? message;
  Data? data;

  PaymentGatewayModel({this.success, this.message, this.data});

  PaymentGatewayModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? orderId;
  List<String>? paymentId;

  Data({this.orderId, this.paymentId});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'].cast<String>();
    paymentId = json['payment_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['payment_id'] = this.paymentId;
    return data;
  }
}
