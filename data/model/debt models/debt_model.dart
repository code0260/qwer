import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/datetime%20functions/to_local_datetime.dart';
import 'package:equatable/equatable.dart';

class DebtModel extends Equatable {
  final int? debtsId;
  final int? debtsBusinessId;
  final int? debtsInvoicesId;
  final int? debtsClientsId;
  final int? debtsEmployeesId;
  final String? debtsPersonName;
  final String? debtsPersonNameType;
  final String? debtsState;
  final double? debtsTotalAmount;
  final double? debtsPaidAmount;
  final double? debtsTotalAmountInBase; // New property
  final double? debtsPaidAmountInBase; // New property
  final int? debtsAmountCurrencyId; // New property
  final String? debtsDueDate;
  final String? debtsCreatedAt;
  final String? debtsAppliedAt;
  final String? debtsUpdatedAt;

  final int? invoicesId;
  final String? invoicesType; // Existing property
  final String? invoicesNumber;
  final String? clientsName; // Existing property
  final String? clientsType; // Existing property
  final int? clientsId; // Existing property

  const DebtModel({
    this.debtsId,
    this.invoicesId,
    this.debtsBusinessId,
    this.debtsInvoicesId,
    this.debtsClientsId,
    this.debtsEmployeesId,
    this.debtsPersonName,
    this.debtsPersonNameType,
    this.debtsState,
    this.debtsTotalAmount,
    this.debtsPaidAmount,
    this.debtsTotalAmountInBase, // New property
    this.debtsPaidAmountInBase, // New property
    this.debtsAmountCurrencyId, // New property
    this.debtsDueDate,
    this.debtsCreatedAt,
    this.debtsAppliedAt,
    this.debtsUpdatedAt,
    this.invoicesType, // Existing property
    this.invoicesNumber, // Existing property
    this.clientsName, // Existing property
    this.clientsType, // Existing property
    this.clientsId, // Existing property
  });

  factory DebtModel.fromJson(Map<String, dynamic> json) {
    // Convert time-related fields from UTC to local time
    String? debtsDueDate = toLocalTime(json['debts_due_date']);
    String? debtsCreatedAt = toLocalTime(json['debts_created_at']);
    String? debtsAppliedAt = toLocalTime(json['debts_applied_at']);
    String? debtsUpdatedAt = toLocalTime(json['debts_updated_at']);
    return DebtModel(
      debtsId: json['debts_id'] as int?,
      invoicesId: json['invoices_id'] as int?,
      debtsBusinessId: json['debts_business_id'] as int?,
      debtsInvoicesId: json['debts_invoices_id'] as int?,
      debtsClientsId: json['debts_clients_id'] as int?,
      debtsEmployeesId: json['debts_employees_id'] as int?,
      debtsPersonName: json['debts_person_name'] as String?,
      debtsPersonNameType: json['debts_person_name_type'] as String?,
      debtsState: json['debts_state'] as String?,
      debtsTotalAmount: json['debts_total_amount'] is String?
          ? (json['debts_total_amount'] as String?)?.toDouble()
          : json['debts_total_amount'] as double,
      debtsPaidAmount: json['debts_paid_amount'] is String?
          ? (json['debts_paid_amount'] as String?)?.toDouble()
          : json['debts_paid_amount'] as double,
      debtsTotalAmountInBase: json['debts_total_amount_in_base'] is String?
          ? (json['debts_total_amount_in_base'] as String?)?.toDouble()
          : json['debts_total_amount_in_base'] as double,
      debtsPaidAmountInBase: json['debts_paid_amount_in_base'] is String?
          ? (json['debts_paid_amount_in_base'] as String?)?.toDouble()
          : json['debts_paid_amount_in_base'] as double,
      debtsAmountCurrencyId: json['debts_amount_currency_id'] as int?,
      debtsDueDate: debtsDueDate,
      debtsCreatedAt: debtsCreatedAt,
      debtsAppliedAt: debtsAppliedAt,
      debtsUpdatedAt: debtsUpdatedAt,
      invoicesType: json['invoices_type'] as String?,
      invoicesNumber: json['invoices_number'] as String?,
      clientsName: json['clients_name'] as String?,
      clientsType: json['clients_type'] as String?,
      clientsId: json['clients_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    String? debtsDueDate = this.debtsDueDate;
    String? debtsCreatedAt = this.debtsCreatedAt;
    String? debtsUpdatedAt = this.debtsUpdatedAt;

    if (debtsDueDate != null) {
      debtsDueDate = DateTime.parse(debtsDueDate).toUtc().toString();
    }
    if (debtsCreatedAt != null) {
      debtsCreatedAt = DateTime.parse(debtsCreatedAt).toUtc().toString();
    }
    if (debtsUpdatedAt != null) {
      debtsUpdatedAt = DateTime.parse(debtsUpdatedAt).toUtc().toString();
    }

    return {
      'debts_id': debtsId,
      'invoices_id': invoicesId,
      'debts_business_id': debtsBusinessId,
      'debts_invoices_id': debtsInvoicesId,
      'debts_clients_id': debtsClientsId,
      'debts_employees_id': debtsEmployeesId,
      'debts_person_name': debtsPersonName,
      'debts_person_name_type': debtsPersonNameType,
      'debts_state': debtsState,
      'debts_total_amount': debtsTotalAmount,
      'debts_paid_amount': debtsPaidAmount,
      'debts_total_amount_in_base': debtsTotalAmountInBase,
      'debts_paid_amount_in_base': debtsPaidAmountInBase,
      'debts_amount_currency_id': debtsAmountCurrencyId,
      'debts_due_date': debtsDueDate,
      'debts_created_at': debtsCreatedAt,
      'debts_applied_at': debtsAppliedAt,
      'debts_updated_at': debtsUpdatedAt,
      'invoices_type': invoicesType,
      'clients_name': clientsName,
      'clients_type': clientsType,
      'clients_id': clientsId,
    };
  }

  Map<String, dynamic> toMap() {
    var map = toJson();
    map.removeWhere((key, value) => value == null);
    return map;
  }

  DebtModel copyWith({
    int? debtsId,
    int? debtsBusinessId,
    int? debtsInvoicesId,
    int? debtsClientsId,
    int? debtsEmployeesId,
    String? debtsPersonName,
    String? debtsPersonNameType,
    String? debtsState,
    double? debtsTotalAmount,
    double? debtsPaidAmount,
    double? debtsTotalAmountInBase,
    double? debtsPaidAmountInBase,
    int? debtsAmountCurrencyId,
    String? debtsDueDate,
    String? debtsCreatedAt,
    String? debtsAppliedAt,
    String? debtsUpdatedAt,
    String? invoicesType,
    int? invoicesId,
    String? invoicesNumber,
    String? clientsName,
    String? clientsType,
    int? clientsId,
  }) {
    return DebtModel(
      debtsId: debtsId ?? this.debtsId,
      debtsBusinessId: debtsBusinessId ?? this.debtsBusinessId,
      debtsInvoicesId: debtsInvoicesId ?? this.debtsInvoicesId,
      debtsClientsId: debtsClientsId ?? this.debtsClientsId,
      debtsEmployeesId: debtsEmployeesId ?? this.debtsEmployeesId,
      debtsPersonName: debtsPersonName ?? this.debtsPersonName,
      debtsPersonNameType: debtsPersonNameType ?? this.debtsPersonNameType,
      debtsState: debtsState ?? this.debtsState,
      debtsTotalAmount: debtsTotalAmount ?? this.debtsTotalAmount,
      debtsPaidAmount: debtsPaidAmount ?? this.debtsPaidAmount,
      invoicesId: invoicesId ?? this.invoicesId,
      debtsTotalAmountInBase:
          debtsTotalAmountInBase ?? this.debtsTotalAmountInBase,
      debtsPaidAmountInBase:
          debtsPaidAmountInBase ?? this.debtsPaidAmountInBase,
      debtsAmountCurrencyId:
          debtsAmountCurrencyId ?? this.debtsAmountCurrencyId,
      debtsDueDate: debtsDueDate ?? this.debtsDueDate,
      debtsCreatedAt: debtsCreatedAt ?? this.debtsCreatedAt,
      debtsAppliedAt: debtsAppliedAt ?? this.debtsAppliedAt,
      debtsUpdatedAt: debtsUpdatedAt ?? this.debtsUpdatedAt,
      invoicesType: invoicesType ?? this.invoicesType,
      invoicesNumber: invoicesNumber ?? this.invoicesNumber,
      clientsName: clientsName ?? this.clientsName,
      clientsType: clientsType ?? this.clientsType,
      clientsId: clientsId ?? this.clientsId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      debtsId,
      debtsBusinessId,
      debtsInvoicesId,
      debtsClientsId,
      debtsAppliedAt,
      debtsEmployeesId,
      debtsPersonName,
      debtsPersonNameType,
      debtsState,
      debtsTotalAmount,
      debtsPaidAmount,
      debtsTotalAmountInBase,
      debtsPaidAmountInBase,
      debtsAmountCurrencyId,
      debtsDueDate,
      debtsCreatedAt,
      debtsUpdatedAt,
      invoicesType,
      invoicesNumber,
      clientsName,
      clientsType,
      clientsId,
    ];
  }
}
