class CustomersModel {
  int? id;
  String? name;
  String? phone;
  int? townId;
  String? townName;
  int? districtId;
  String? districtName;
  String? createdAt;
  String? updatedAt;


  CustomersModel(townid,
      {this.id,
      this.name,
      this.phone,
      this.townId,
      this.townName,
      this.districtId,
      this.districtName,
      this.createdAt,
      this.updatedAt,
      });

  CustomersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    
    townId = json['town_id'];
    townName = json['town_name'];
    
    districtId = json['district_id'];
    districtName = json['district_name'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;

    data['town_id'] = this.townId;
    data['town_name'] = this.townName;

    data['district_id'] = this.districtId;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    
    return data;
  }
}








