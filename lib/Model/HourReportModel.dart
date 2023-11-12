class HourReportModel {
  int hour;
  String count;

  HourReportModel({
    required this.hour,
    required this.count,
  });

  factory HourReportModel.fromJson(Map<String, dynamic> json) {
    return HourReportModel(
      hour: json['hour'],
      count: json['count'],
    );
  }
}