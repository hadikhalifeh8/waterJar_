class NoteModel {
  int? id;
  String? name;
  String? title;
  String? color;
  String? mobile;
  String? createdAt;
  String? updatedAt;

  NoteModel(
      {this.id,
      this.name,
      this.title,
      this.color,
      this.mobile,
      this.createdAt,
      this.updatedAt});

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    color = json['color'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    data['color'] = this.color;
    data['mobile'] = this.mobile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}