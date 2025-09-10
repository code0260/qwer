import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class RevenuesModel extends Equatable {
  final int? revenuesId;
  final String? revenuesName;
  final dynamic revenuesDescription;
  final double? revenuesAmount;
  final int? revenuesAccountId;
  final String? revenuesCreatedAt;
  final String? revenuesType;
  final double? revenuesSecondAmount;
  final double? revenuesAmountInBase; // New property
  final double? revenuesSecondAmountInBase; // New property
  final int? revenuesAmountCurrencyId; // New property

  const RevenuesModel({
    this.revenuesId,
    this.revenuesName,
    this.revenuesDescription,
    this.revenuesAmount,
    this.revenuesAccountId,
    this.revenuesCreatedAt,
    this.revenuesType,
    this.revenuesSecondAmount,
    this.revenuesAmountInBase, // Added to constructor
    this.revenuesSecondAmountInBase, // Added to constructor
    this.revenuesAmountCurrencyId, // Added to constructor
  });

  factory RevenuesModel.fromJson(Map<String, dynamic> json) => RevenuesModel(
        revenuesId: json['revenues_id'] as int?,
        revenuesName: json['revenues_name'] as String?,
        revenuesDescription: json['revenues_description'],
        revenuesAmount: receiveDouble(json['revenues_amount']),
        revenuesAccountId: json['revenues_account_id'] as int?,
        revenuesCreatedAt: json['revenues_created_at'] != null
            ? parseUtcToLocal(json['revenues_created_at'] as String)
            : null,
        revenuesType: json['revenues_type'] as String?,
        revenuesSecondAmount: receiveDouble(json['revenues_second_amount']),
        revenuesAmountInBase: receiveDouble(
            json['revenues_amount_in_base']), // Parse new property
        revenuesSecondAmountInBase: receiveDouble(
            json['revenues_second_amount_in_base']), // Parse new property
        revenuesAmountCurrencyId:
            json['revenues_amount_currency_id'] as int?, // Parse new property
      );

  Map<String, dynamic> toJson() => {
        'revenues_id': revenuesId,
        'revenues_name': revenuesName,
        'revenues_description': revenuesDescription,
        'revenues_amount': revenuesAmount,
        'revenues_account_id': revenuesAccountId,
        'revenues_created_at': parseLocalToUtc(revenuesCreatedAt),
        'revenues_type': revenuesType,
        'revenues_second_amount': revenuesSecondAmount,
        'revenues_amount_in_base': revenuesAmountInBase, // Add new property
        'revenues_second_amount_in_base':
            revenuesSecondAmountInBase, // Add new property
        'revenues_amount_currency_id':
            revenuesAmountCurrencyId, // Add new property
      };

  RevenuesModel copyWith({
    int? revenuesId,
    String? revenuesName,
    dynamic revenuesDescription,
    double? revenuesAmount,
    int? revenueAccountId,
    String? revenuesCreatedAt,
    String? revenuesType,
    double? revenuesSecondAmount,
    double? revenuesAmountInBase, // Add new property
    double? revenuesSecondAmountInBase, // Add new property
    int? revenuesAmountCurrencyId, // Add new property
  }) {
    return RevenuesModel(
      revenuesId: revenuesId ?? this.revenuesId,
      revenuesName: revenuesName ?? this.revenuesName,
      revenuesDescription: revenuesDescription ?? this.revenuesDescription,
      revenuesAmount: revenuesAmount ?? this.revenuesAmount,
      revenuesAccountId: revenueAccountId ?? revenuesAccountId,
      revenuesCreatedAt: revenuesCreatedAt ?? this.revenuesCreatedAt,
      revenuesType: revenuesType ?? this.revenuesType,
      revenuesSecondAmount: revenuesSecondAmount ?? this.revenuesSecondAmount,
      revenuesAmountInBase:
          revenuesAmountInBase ?? this.revenuesAmountInBase, // Add new property
      revenuesSecondAmountInBase: revenuesSecondAmountInBase ??
          this.revenuesSecondAmountInBase, // Add new property
      revenuesAmountCurrencyId: revenuesAmountCurrencyId ??
          this.revenuesAmountCurrencyId, // Add new property
    );
  }

  static String? parseUtcToLocal(String? date) {
    return date != null ? DateTime.parse(date).toLocal().toString() : null;
  }

  static String? parseLocalToUtc(String? date) {
    return date != null ? DateTime.parse(date).toUtc().toString() : null;
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      revenuesId,
      revenuesName,
      revenuesDescription,
      revenuesAmount,
      revenuesAccountId,
      revenuesCreatedAt,
      revenuesType,
      revenuesSecondAmount,
      revenuesAmountInBase, // Add new property
      revenuesSecondAmountInBase, // Add new property
      revenuesAmountCurrencyId, // Add new property
    ];
  }
}
