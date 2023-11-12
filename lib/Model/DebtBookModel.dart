class DebtBookModel {

  String? name;
  String? phone;
  String? dept;

  DebtBookModel(
      {
        this.name,
        this.phone
      });

  DebtBookModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    phone = json['phone'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name.toString();
    data['phone'] = this.phone.toString();
    data['phone'] = this.phone.toString();

    return data;
  }
}