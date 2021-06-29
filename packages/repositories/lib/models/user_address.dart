class UserAddress {
  String? name;
  String? address;
  double? latitude;
  double? longitude;

  UserAddress({this.name, this.address, this.latitude, this.longitude});

  UserAddress.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.address = json["address"];
    this.latitude = json["latitude"];
    this.longitude = json["longitude"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["address"] = this.address;
    data["latitude"] = this.latitude;
    data["longitude"] = this.longitude;
    return data;
  }
}
