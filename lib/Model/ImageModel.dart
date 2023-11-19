class ImageModel {


  String? id;
  String? path;
  String? type;


  ImageModel(
      {
        /////
        this.id,
        this.path,
        this.type,
     });

  ImageModel.fromJson(Map<String, dynamic> json) {

    ///////
    id = json['id'];
    path = json['path'];
    type = json['type'];
    /////

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id.toString();
    data['path'] = this.path.toString();
    data['type'] = this.type.toString();

    return data;
  }
}