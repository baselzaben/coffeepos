class LoginModel {

  String? coffeeId;
  String? id;
  String? image;
  String? name;
  String? passwordd;
  String? phone;
  String? username;
  String? usertype;

  String? locationn;
  String? coffename;
  String? message;
  String? expierdate;

  //////////////////////////

  String? inititem;
  String? debitpersion;
  String? debtbook;
  String? addqt ;
  String? report  ;


  LoginModel(
      {this.coffeeId,
        this.id,
        this.image,
        this.name,
        this.passwordd,
        this.phone,
        this.username,
        this.usertype,
        this.message,
        this.expierdate,

        /////
        this.inititem,
        this.debitpersion,
        this.debtbook,
        this.addqt,
        this.report,
        ////
  this.locationn,
  this.coffename});

  LoginModel.fromJson(Map<String, dynamic> json) {
    coffeeId = json['coffeeId'];
    ///////

    expierdate = json['expierdate'];
    inititem = json['inititem'];
    debitpersion = json['debitpersion'];
    debtbook = json['debtbook'];
    addqt = json['addqt'];
    report = json['report'];
    /////
    id = json['id'];
    image = json['image'];
    name = json['name'];
    passwordd = json['passwordd'];
    phone = json['phone'];
    username = json['username'];
    usertype = json['usertype'];
locationn = json['locationn'];
    coffename = json['coffename'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coffeeId'] = this.coffeeId.toString();
    data['id'] = this.id.toString();
    data['image'] = this.image.toString();
    data['name'] = this.name.toString();
    data['passwordd'] = this.passwordd.toString();
    data['phone'] = this.phone.toString();
    /////

    data['expierdate'] = this.expierdate.toString();
    data['inititem'] = this.inititem.toString();
    data['debitpersion'] = this.debitpersion.toString();
    data['debtbook'] = this.debtbook.toString();
    data['addqt'] = this.addqt.toString();
    data['report'] = this.report.toString();
    ////
    data['username'] = this.username.toString();
    data['usertype'] = this.usertype.toString();
    data['message'] = this.message.toString();

    data['locationn'] = this.locationn.toString();
    data['coffename'] = this.coffename.toString();
    return data;
  }
}