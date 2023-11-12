class PermisionModel {


  //////////////////////////

  String? inititem;
  String? debitpersion;
  String? debtbook;
  String? addqt ;
  String? report  ;


  PermisionModel(
      {
        /////
        this.inititem,
        this.debitpersion,
        this.debtbook,
        this.addqt,
        this.report});

  PermisionModel.fromJson(Map<String, dynamic> json) {

    ///////
    inititem = json['inititem'];
    debitpersion = json['debitpersion'];
    debtbook = json['debtbook'];
    addqt = json['addqt'];
    report = json['report'];
    /////

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['inititem'] = this.inititem.toString();
    data['debitpersion'] = this.debitpersion.toString();
    data['debtbook'] = this.debtbook.toString();
    data['addqt'] = this.addqt.toString();
    data['report'] = this.report.toString();

    return data;
  }
}