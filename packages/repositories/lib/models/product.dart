class Product {
  String? title;
  String? type;
  String? description;
  String? filename;
  int? height;
  int? width;
  double? price;
  double? rating;
  int? productId;

  Product(
      {this.title,
      this.type,
      this.description,
      this.filename,
      this.height,
      this.width,
      this.price,
      this.rating,
      this.productId});

  Product.fromJson(Map<String, dynamic> json) {
    this.title = json["title"];
    this.type = json["type"];
    this.description = json["description"];
    this.filename = json["filename"];
    this.height = json["height"]?.toInt();
    this.width = json["width"]?.toInt();
    this.price = json["price"]?.toDouble();
    this.rating = json["rating"]?.toDouble();
    this.productId = json["productId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["title"] = this.title;
    data["type"] = this.type;
    data["description"] = this.description;
    data["filename"] = this.filename;
    data["height"] = this.height;
    data["width"] = this.width;
    data["price"] = this.price;
    data["rating"] = this.rating;
    data["productId"] = this.productId;
    return data;
  }
}
