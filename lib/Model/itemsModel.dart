class itemsModel {

  String? id;
  String? itemimage;
  String? itemname;
  String? coffeid;
  String? itemprice;
  String? iteminitprice;
  String? classid;
  int qt=0;
  int userid=0;
  String invid='0';

  String? nowqt;

  String? enableqt;

  itemsModel(
      {
        this.id,
        this.itemname,
        this.itemimage,
        this.coffeid,
        this.itemprice,
        this.iteminitprice,
        this.classid,
        this.nowqt,
        this.enableqt,
        required this.qt,
        required this.invid,
        required this.userid
      });

  itemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemimage = json['itemimage'];
    itemname = json['itemname'];
    coffeid = json['coffeid'];
    itemprice = json['itemprice'];
    iteminitprice = json['iteminitprice'];
    classid = json['classid'];
    nowqt = json['nowqt'];
    enableqt = json['enableqt'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['itemimage'] = this.itemimage.toString();
    data['itemname'] = this.itemname.toString();
    data['coffeid'] = this.coffeid.toString();
    data['itemprice'] = this.itemprice.toString();
    data['iteminitprice'] = this.iteminitprice.toString();
    data['classid'] = this.classid.toString();
    data['qt'] = this.qt.toString();
    data['invid'] = this.invid.toString();
    data['userid'] = this.userid.toString();
    data['nowqt'] = this.nowqt;
    data['enableqt'] = this.enableqt;

    return data;
  }
}