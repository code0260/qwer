class SellsGraphModel {
  final String date; // Date as string from API
  final double sales; // Sales value from API

  SellsGraphModel({required this.date, required this.sales});

  // Factory method to create an instance from JSON
  factory SellsGraphModel.fromJson(Map<String, dynamic> json) {
    return SellsGraphModel(
      date: json['sale_date'] ?? '',
      sales: double.tryParse(json['total_sales'].toString()) ?? 0.0,
    );
  }

  // Converts a list of JSON objects into a list of SellsGraphModel
  static List<SellsGraphModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SellsGraphModel.fromJson(json)).toList();
  }
}
