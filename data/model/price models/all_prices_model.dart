import 'package:almonazim/data/model/price%20models/price_model.dart';

class AllPricesModel {
  final List<PriceModel> sell;
  final List<PriceModel> buy;

  AllPricesModel({required this.sell, required this.buy});

  factory AllPricesModel.formJson(Map<String, dynamic> map) {
    return AllPricesModel(
      sell: map['sell'] == null
          ? []
          : List<PriceModel>.from(
              (map['sell'] as List<dynamic>).map<PriceModel>(
                (x) => PriceModel.fromJson(x as Map<String, dynamic>),
              ),
            ),
      buy: map['buy'] == null
          ? []
          : List<PriceModel>.from(
              (map['buy'] as List<dynamic>).map<PriceModel>(
                (x) => PriceModel.fromJson(x as Map<String, dynamic>),
              ),
            ),
    );
  }
}
