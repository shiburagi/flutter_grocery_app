class Cart {
  int? productId;
  int? quantity;
  String? instructions;
  double? pricePerUnit;

  Cart({this.productId, this.quantity, this.instructions, this.pricePerUnit});

  Cart.fromJson(Map<String, dynamic> json) {
    this.productId = json["productId"];
    this.quantity = json["quantity"];
    this.instructions = json["instructions"];
    this.pricePerUnit = json["pricePerUnit"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["productId"] = this.productId;
    data["quantity"] = this.quantity;
    data["instructions"] = this.instructions;
    data["pricePerUnit"] = this.pricePerUnit;
    return data;
  }
}
