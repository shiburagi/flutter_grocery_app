class PaymentOption {
  String? name;
  String? type;
  String? cardNo;
  String? expiredDate;

  PaymentOption({this.name, this.type, this.cardNo, this.expiredDate});

  PaymentOption.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.type = json["type"];
    this.cardNo = json["card_no"];
    this.expiredDate = json["expired_date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["type"] = this.type;
    data["card_no"] = this.cardNo;
    data["expired_date"] = this.expiredDate;
    return data;
  }
}
