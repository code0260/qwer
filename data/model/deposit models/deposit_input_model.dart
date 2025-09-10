import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';

class DepositInputModel {
  int? depositsId;
  int? depositsPartnerId;
  double? depositsCashAmount; // Changed type to double?
  double? depositsAmountInBase; // New field
  int? depositsAmountCurrencyId; // New field
  String? depositsNotes;
  String? depositsCreatedAt;
  String? depositsUpdatedAt;
  DateTime? startDate;
  DateTime? endDate;
  String? partnerName;

  DepositInputModel({
    this.depositsId,
    this.depositsPartnerId,
    this.depositsCashAmount,
    this.depositsAmountInBase, // New field
    this.depositsAmountCurrencyId, // New field
    this.depositsNotes,
    this.depositsCreatedAt,
    this.depositsUpdatedAt,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
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
      'start_date': startDate?.toUtc().toString(),
      'end_date': endDate?.toUtc().toString(),
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory DepositInputModel.fromMap(Map<String, dynamic> map) {
    return DepositInputModel(
      depositsId: map['deposits_id'] as int?,
      depositsPartnerId: map['deposits_partner_id'] as int?,
      depositsCashAmount:
          receiveDouble(map['deposits_cash_amount']), // Updated parsing logic
      depositsAmountInBase:
          receiveDouble(map['deposits_amount_in_base']), // New field
      depositsAmountCurrencyId:
          map['deposits_amount_currency_id'] as int?, // New field
      depositsNotes: map['deposits_notes'] as String?,
      depositsCreatedAt: map['deposits_created_at'] == null
          ? null
          : DateTime.parse('${map['deposits_created_at']}Z')
              .toLocal()
              .toString(),
      depositsUpdatedAt: map['deposits_updated_at'] == null
          ? null
          : DateTime.parse('${map['deposits_updated_at']}Z')
              .toLocal()
              .toString(),
      startDate: map['start_date'] != null
          ? DateTime.parse(map['start_date']).toLocal()
          : null,
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date']).toLocal()
          : null,
    );
  }

  @override
  String toString() {
    return 'DepositInputModel('
        'depositsId: $depositsId, '
        'depositsPartnerId: $depositsPartnerId, '
        'depositsCashAmount: $depositsCashAmount, '
        'depositsAmountInBase: $depositsAmountInBase, ' // New field
        'depositsAmountCurrencyId: $depositsAmountCurrencyId, ' // New field
        'depositsNotes: $depositsNotes, '
        'depositsCreatedAt: $depositsCreatedAt, '
        'depositsUpdatedAt: $depositsUpdatedAt, '
        'startDate: $startDate, '
        'endDate: $endDate)';
  }

  @override
  bool operator ==(covariant DepositInputModel other) {
    if (identical(this, other)) return true;
    return other.depositsId == depositsId &&
        other.depositsPartnerId == depositsPartnerId &&
        other.depositsCashAmount == depositsCashAmount &&
        other.depositsAmountInBase == depositsAmountInBase && // New field
        other.depositsAmountCurrencyId ==
            depositsAmountCurrencyId && // New field
        other.depositsNotes == depositsNotes &&
        other.depositsCreatedAt == depositsCreatedAt &&
        other.depositsUpdatedAt == depositsUpdatedAt &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return depositsId.hashCode ^
        depositsPartnerId.hashCode ^
        depositsCashAmount.hashCode ^
        depositsAmountInBase.hashCode ^ // New field
        depositsAmountCurrencyId.hashCode ^ // New field
        depositsNotes.hashCode ^
        depositsCreatedAt.hashCode ^
        depositsUpdatedAt.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}
