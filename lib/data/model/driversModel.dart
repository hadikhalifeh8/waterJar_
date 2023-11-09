class DriversModel {
  int? id;
  String? name;
  String? phone;
  String? password;


  String? createdAt;
  String? updatedAt;

  DriversModel(
      {this.id,
      this.name,
      this.phone,
      this.password,
      this.createdAt,
      this.updatedAt});

  DriversModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}