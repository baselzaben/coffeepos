class classessModel {

  String? classname;
  String? id;
  String? coffeid;
  String? classimage;


  classessModel(
      {this.classname,
        this.id,
        this.coffeid,
        this.classimage});

  classessModel.fromJson(Map<String, dynamic> json) {
    classname = json['classname'];
    id = json['id'];
    coffeid = json['coffeid'];
    classimage = json['classimage'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classname'] = this.classname.toString();
    data['id'] = this.id.toString();
    data['coffeid'] = this.coffeid.toString();
    data['classimage'] = this.classimage.toString();

    return data;
  }
}