class JarModels {
  int? id;
  String? name;
  double? price;

  String? createdAt;
  String? updatedAt;


  JarModels(townid,
      {this.id,
      this.name,
      this.price,

      this.createdAt,
      this.updatedAt,
      });

  JarModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    
    return data;
  }
}








