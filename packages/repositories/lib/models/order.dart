import 'package:repositories/models/cart.dart';

class Order {
  String? refId;
  int? createdMillis;
  String? userId;
  String? status;
  List<Fees>? fees;
  List<Cart>? items;

  Order(
      {this.refId,
      this.createdMillis,
      this.userId,
      this.status,
      this.fees,
      this.items});

  Order.fromJson(Map<String, dynamic> json) {
    this.refId = json["refId"];
    this.createdMillis = json["created_millis"];
    this.userId = json["user_id"];
    this.status = json["status"];
    this.fees = json["fees"] == null
        ? null
        : (json["fees"] as List).map((e) => Fees.fromJson(e)).toList();
    this.items = json["items"] == null
        ? null
        : (json["items"] as List).map((e) => Cart.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["refId"] = this.refId;
    data["created_millis"] = this.createdMillis;
    data["user_id"] = this.userId;
    data["status"] = this.status;
    if (this.fees != null)
      data["fees"] = this.fees?.map((e) => e.toJson()).toList();
    if (this.items != null)
      data["items"] = this.items?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Fees {
  String? name;
  double? percent;
  double? amount;

  Fees({this.name, this.percent, this.amount});

  Fees.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.percent = json["percent"];
    this.amount = json["amount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["percent"] = this.percent;
    data["amount"] = this.amount;
    return data;
  }
}
