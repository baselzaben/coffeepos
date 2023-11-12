class userRmodel {
  String name;
  String total_sales;

  userRmodel({
    required this.name,
    required this.total_sales,
  });

  factory userRmodel.fromJson(Map<String, dynamic> json) {
    return userRmodel(
      name: json['name'],
      total_sales: json['total_sales'],
    );
  }
}