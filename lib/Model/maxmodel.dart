
class maxmodel {

  int? maxinv;

  maxmodel(
      {this.maxinv});

  maxmodel.fromJson(Map<String, dynamic> json) {
    maxinv = json['maxinv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxinv'] = this.maxinv;


    return data;
  }
}