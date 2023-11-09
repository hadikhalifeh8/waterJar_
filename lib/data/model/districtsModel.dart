class DistrictsModel {
  int? id;
  String? name;
  int? townId;
  String? townName;
  String? createdAt;
  String? updatedAt;


  DistrictsModel(townid,
      {this.id,
      this.name,
      this.townId,
      this.townName,
      this.createdAt,
      this.updatedAt,
      });

  DistrictsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    townId = json['town_id'];
    townName = json['town_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['town_id'] = this.townId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    
    return data;
  }
}








