
class SumSaleModel {
  String totalSales;
  String totalSales_thidhour;

  SumSaleModel({
    required this.totalSales,
    required this.totalSales_thidhour,
  });

  factory SumSaleModel.fromJson(Map<String, dynamic> json) {
    return SumSaleModel(
      totalSales: json['total_sales'],
      totalSales_thidhour: json['total_sales_this_hour'],
    );
  }
}