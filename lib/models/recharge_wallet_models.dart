class RechargeWalletModel {
  bool? success;
  String? message;
  List<DataRecharge>? data;

  RechargeWalletModel({this.success, this.message, this.data});

  RechargeWalletModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataRecharge>[];
      json['data'].forEach((v) {
        data!.add(new DataRecharge.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataRecharge {
  int? price;
  String? discount;
  int? walletPrice;

  DataRecharge({this.price, this.discount, this.walletPrice});

  DataRecharge.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    discount = json['discount'];
    walletPrice = json['wallet_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['wallet_price'] = this.walletPrice;
    return data;
  }
}
