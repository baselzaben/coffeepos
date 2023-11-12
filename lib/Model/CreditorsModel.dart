
class CreditorsModel {

String? id;
String? name;
String? address;
String? phone;
String? dept;
String?  coffeid;

String? max;





CreditorsModel(
{
this.id,
this.name,
this.address,
this.phone,
this.dept,
this.coffeid,
this.max

});

CreditorsModel.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  name = json['name'];
  address = json['address'];

  phone = json['phone'];
  dept = json['dept'];
  coffeid = json['coffeid'];


  max = json['max'];


}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id.toString();
data['name'] = this.name.toString();
data['address'] = this.address.toString();

data['phone'] = this.phone.toString();
data['dept'] = this.dept.toString();
data['coffeid'] = this.coffeid.toString();

data['max'] = this.max.toString();

return data;
}
}