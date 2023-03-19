class PaymentHistoryModel {
  int? id;
  int? customerId;
  String? paymentId;
  String? paymentMethod;
  String? createdAt;
  String? updatedAt;
  dynamic amount;
  dynamic walletAmount;
  dynamic gst;
  String? orderId;
  dynamic totalAmount;

  PaymentHistoryModel({
    this.id,
    this.customerId,
    this.paymentId,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
    this.amount,
    this.walletAmount,
    this.gst,
    this.orderId,
    this.totalAmount,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryModel(
      id: json['id'],
      customerId: json['customer_id'],
      paymentId: json['payment_id'],
      paymentMethod: json['payment_method'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      amount: json['amount'],
      walletAmount: json['wallet_amount'],
      gst: json['gst'],
      orderId: json['order_id'],
      totalAmount: json['total_amount'],
    );
  }
}
