import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class DepositModel extends Equatable {
  final int? depositsId;
  final int? depositsPartnerId;
  final double? depositsCashAmount; // Changed type to double?
  final double? depositsAmountInBase; // New field
  final int? depositsAmountCurrencyId; // New field
  final String? depositsNotes;
  final String? depositsCreatedAt;
  final String? depositsUpdatedAt;

  const DepositModel({
    this.depositsId,
    this.depositsPartnerId,
    this.depositsCashAmount,
    this.depositsAmountInBase, // New field
    this.depositsAmountCurrencyId, // New field
    this.depositsNotes,
    this.depositsCreatedAt,
    this.depositsUpdatedAt,
  });

  factory DepositModel.fromJson(Map<String, dynamic> json) => DepositModel(
        depositsId: json['deposits_id'] as int?,
        depositsPartnerId: json['deposits_partner_id'] as int?,
        depositsCashAmount: receiveDouble(
            json['deposits_cash_amount']), // Updated parsing logic
        depositsAmountInBase:
            receiveDouble(json['deposits_amount_in_base']), // New field
        depositsAmountCurrencyId:
            json['deposits_amount_currency_id'] as int?, // New field
        depositsNotes: json['deposits_notes'] as String?,
        depositsCreatedAt: json['deposits_created_at'] == null
            ? null
            : DateTime.parse('${json['deposits_created_at']}Z')
                .toLocal()
                .toString(),
        depositsUpdatedAt: json['deposits_updated_at'] == null
            ? null
            : DateTime.parse('${json['deposits_updated_at']}Z')
                .toLocal()
                .toString(),
      );

  Map<String, dynamic> toJson() => {
        'deposits_id': depositsId,
        'deposits_partner_id': depositsPartnerId,
        'deposits_cash_amount': depositsCashAmount, // Updated field
        'deposits_amount_in_base': depositsAmountInBase, // New field
        'deposits_amount_currency_id': depositsAmountCurrencyId, // New field
        'deposits_notes': depositsNotes,
        'deposits_created_at': depositsCreatedAt == null
            ? null
            : DateTime.parse(depositsCreatedAt!).toUtc().toString(),
        'deposits_updated_at': depositsUpdatedAt == null
            ? null
            : DateTime.parse(depositsUpdatedAt!).toUtc().toString(),
      };

  DepositModel copyWith({
    int? depositsId,
    int? depositsPartnerId,
    double? depositsCashAmount, // Updated type
    double? depositsAmountInBase, // New field
    int? depositsAmountCurrencyId, // New field
    String? depositsNotes,
    String? depositsCreatedAt,
    String? depositsUpdatedAt,
  }) {
    return DepositModel(
      depositsId: depositsId ?? this.depositsId,
      depositsPartnerId: depositsPartnerId ?? this.depositsPartnerId,
      depositsCashAmount:
          depositsCashAmount ?? this.depositsCashAmount, // Updated field
      depositsAmountInBase:
          depositsAmountInBase ?? this.depositsAmountInBase, // New field
      depositsAmountCurrencyId: depositsAmountCurrencyId ??
          this.depositsAmountCurrencyId, // New field
      depositsNotes: depositsNotes ?? this.depositsNotes,
      depositsCreatedAt: depositsCreatedAt ?? this.depositsCreatedAt,
      depositsUpdatedAt: depositsUpdatedAt ?? this.depositsUpdatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      depositsId,
      depositsPartnerId,
      depositsCashAmount, // Updated field
      depositsAmountInBase, // New field
      depositsAmountCurrencyId, // New field
      depositsNotes,
      depositsCreatedAt,
      depositsUpdatedAt,
    ];
  }
}
