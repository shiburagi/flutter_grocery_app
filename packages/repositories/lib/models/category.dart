class Category {
  String? type;
  String? filename;

  Category({this.type, this.filename});

  Category.fromJson(Map<String, dynamic> json) {
    this.type = json["type"];
    this.filename = json["filename"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["type"] = this.type;
    data["filename"] = this.filename;
    return data;
  }
}
