class BottelsModel {
  int? id;
  String? name;
  // int? companyId;
  // String? companyName;
  double? price;
  String? createdAt;
  String? updatedAt;


  BottelsModel(townid,
      {this.id,
      this.name,
      // this.companyId,
      // this.companyName,

      this.price,
      this.createdAt,
      this.updatedAt,
      });

  BottelsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // companyId = json['company_id'];
    // companyName = json['company_name'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    // data['company_id'] = this.companyId;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    
    return data;
  }
}








