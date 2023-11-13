class AppModel {

  String? ip;
  String? message;
  String? terms;
  String? version;
  String? link;
  String? show;



  AppModel(
      {this.ip,
        this.message,
        this.terms,
        this.link,
        this.show,
        this.version});

  AppModel.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    message = json['message'];
    terms = json['terms'];
    version = json['version'];
    link = json['link'];
    show = json['show'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ip'] = this.ip.toString();
    data['message'] = this.message.toString();
    data['terms'] = this.terms.toString();
    data['version'] = this.version.toString();
    data['link'] = this.link.toString();
    data['show'] = this.show.toString();

    return data;
  }
}