// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:almonazim/data/data%20source/locale/store_count_invoice.dart';
import 'package:almonazim/data/model/offer_model/offer_model.dart';
import 'package:almonazim/data/model/price%20models/prices_input_model.dart';
import 'package:almonazim/data/model/product%20models/get_product_model.dart';
import 'package:almonazim/data/model/product%20place%20models/product_place_details_model.dart';
import 'package:almonazim/data/model/taxes%20models/product_tax_model.dart';
import 'package:flutter/foundation.dart';

class SellItemModel {
  final GetProductModel getProductModel;
  final List<ProductPlaceDetailsModel> places;
  late List<ProductPlaceDetailsModel> chosenPlaceModels; // Now a list
  final List<OfferModel>? offers;
  double productCount;
  double? productOriginalCount;
  int? productCountUnitId;
  double? productConversion;
  PriceInputModel editedPriceModel;
  int? currencyId; // New property
  final List<ProductTaxModel> taxes;
  final double taxAmount; // Existing property

  SellItemModel({
    required this.getProductModel,
    required this.productCount,
    this.productCountUnitId,
    this.productOriginalCount = 0,
    this.productConversion,
    required this.offers,
    required this.chosenPlaceModels, // Now a list
    required this.places,
    required this.editedPriceModel, // Existing property
    this.currencyId, // New property
    required this.taxes, // Existing property
    this.taxAmount = 0.0, // Existing property with default value
  });

  factory SellItemModel.fromJson(Map<String, dynamic> json) => SellItemModel(
        places: List.generate(
          json["products_place_details"].length,
          (index) => ProductPlaceDetailsModel.fromJson(
            json['products_place_details'][index],
          ),
        ),
        getProductModel: GetProductModel.fromJson(json['product_data']),
        productCount: (json["product_count"] as num?)?.toDouble() ??
            StoreCountInvoice.getCountInvoice().toDouble(),
        productOriginalCount: receiveDouble(json["product_count"]) ?? 0,
        productCountUnitId: json["product_count_unit_id"],
        productConversion: receiveDouble(json["product_conversion"]),
        chosenPlaceModels: json["chosen_place_models"] != null
            ? List.generate(
                json["chosen_place_models"].length,
                (index) => ProductPlaceDetailsModel.fromJson(
                    json["chosen_place_models"][index]))
            : [
                ProductPlaceDetailsModel.fromJson(
                    json["products_place_details"][0])
              ], // Now handles multiple chosen places
        offers: json["offers"] == null
            ? null
            : List.generate(json["offers"].length,
                (index) => OfferModel.fromJson(json['offers'][index])),
        editedPriceModel: json["edited_price_model"] == null
            ? PriceInputModel()
            : PriceInputModel.fromJson(json["edited_price_model"]),
        currencyId: json["currency_id"] as int?, // New property
        taxes: List.generate(
          json["taxes"]?.length ?? 0, // Handle null or empty list
          (index) => ProductTaxModel.fromJson(json['taxes'][index]),
        ), // Existing property
        taxAmount: json["tax_amount"]?.toDouble() ??
            0.0, // Existing property with parsing and default value
      );

  @override
  bool operator ==(covariant SellItemModel other) {
    if (identical(this, other)) return true;

    return other.getProductModel == getProductModel &&
        listEquals(other.places, places) &&
        listEquals(other.chosenPlaceModels,
            chosenPlaceModels) && // Updated to compare multiple places
        other.productCount == productCount &&
        other.productCountUnitId == productCountUnitId &&
        other.productConversion == productConversion &&
        other.editedPriceModel == editedPriceModel && // Existing property check
        other.currencyId == currencyId && // New property check
        listEquals(other.taxes, taxes) && // Existing property check
        other.taxAmount == taxAmount; // Existing property check
  }

  @override
  int get hashCode {
    return getProductModel.hashCode ^
        places.hashCode ^
        chosenPlaceModels.hashCode ^ // Updated for multiple chosen places
        productCount.hashCode ^
        productCountUnitId.hashCode ^
        productConversion.hashCode ^
        editedPriceModel.hashCode ^ // Existing property hash
        currencyId.hashCode ^ // New property hash
        taxes.hashCode ^ // Existing property hash
        taxAmount.hashCode; // Existing property hash
  }

  Map<String, dynamic> toMap() {
    var priceInputModel = PriceInputModel.fromJson(editedPriceModel.toMap());
    if (editedPriceModel.pricesUnitPrice != null) {
      priceInputModel.pricesAmountCurrencyId = currencyId;
    }
    return <String, dynamic>{
      'product_data': getProductModel.toMap(),
      'products_place_details': places.map((x) => x.toMap()).toList(),
      'chosen_place_models': chosenPlaceModels
          .map((x) => x.toMap())
          .toList(), // Updated for multiple chosen places
      'offers': offers?.map((x) => x.toJson()).toList(),
      'product_count': productCount,
      'product_count_unit_id': productCountUnitId,
      'product_conversion': productConversion,
      'edited_price_model': priceInputModel.toMap(), // Existing property to map
      'currency_id': currencyId, // New property to map
      'taxes':
          taxes.map((x) => x.toJson()).toList(), // Existing property to map
      'tax_amount': taxAmount
    };
  }
}
