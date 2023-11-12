
class EmplyeeModel {

String? id;
String? name;
String? username;
String? phone;
String? passwordd;
String?  coffeeId;
String? usertype;
String? image;
String? total;
String? active;



EmplyeeModel(
{
this.id,
this.name,
this.username,
this.phone,
this.passwordd,
this.coffeeId,
this.usertype,
  this.image,
  this.total,
  this.active

});

EmplyeeModel.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  name = json['name'];
  username = json['username'];

  phone = json['phone'];
  passwordd = json['passwordd'];
  coffeeId = json['coffeeId'];


  usertype = json['usertype'];
  image = json['image'];
  total = json['total'];
  active = json['active'];


}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id.toString();
data['name'] = this.name.toString();
data['username'] = this.username.toString();

data['phone'] = this.phone.toString();
data['passwordd'] = this.passwordd.toString();
data['coffeeId'] = this.coffeeId.toString();

data['usertype'] = this.usertype.toString();
data['image'] = this.image.toString();
data['total'] = this.total.toString();
data['active'] = this.active.toString();

return data;
}
}