// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/constant/app_enums.dart';

class DebtInputModel {
  int? debtsId;
  int? debtsBusinessId;
  int? debtsInvoicesId;
  int? debtsClientsId;
  int? debtsEmployeesId;
  String? debtsPersonName;
  String? debtsPersonNameType;
  String? debtsState;
  double? debtsTotalAmount;
  double? debtsPaidAmount;
  double? debtsPaidThisTime;
  double? debtsTotalAmountInBase; // New property
  double? debtsPaidAmountInBase; // New property
  int? debtsAmountCurrencyId; // New property
  String? debtsDueDate;

  String? invoicesType; // Added property
  String? clientsName; // Added property
  String? clientsType; // Added property
  int? clientsId; // Added property

  AddDebtFrom addDebtFrom;

  DebtInputModel({
    this.debtsId,
    this.debtsBusinessId,
    this.debtsInvoicesId,
    this.debtsClientsId,
    this.addDebtFrom = AddDebtFrom.cash,
    this.debtsEmployeesId,
    this.debtsPaidAmountInBase,
    this.debtsTotalAmountInBase,
    this.debtsPaidThisTime,
    this.debtsAmountCurrencyId,
    this.debtsPersonName,
    this.debtsPersonNameType,
    this.debtsState,
    this.debtsTotalAmount,
    this.debtsPaidAmount,
    this.debtsDueDate,
    this.invoicesType,
    this.clientsName,
    this.clientsType,
    this.clientsId,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'debts_id': debtsId,
      'debts_business_id': debtsBusinessId,
      'debts_invoices_id': debtsInvoicesId,
      'debts_clients_id': debtsClientsId,
      'debts_employees_id': debtsEmployeesId,
      'debts_person_name': debtsPersonName,
      'debts_person_name_type': debtsPersonNameType,
      'debts_state': debtsState,
      'debts_total_amount': debtsTotalAmount,
      'debts_paid_amount': debtsPaidAmount,
      'debts_due_date': debtsDueDate,
      'invoices_type': invoicesType, // Added property
      'clients_name': clientsName, // Added property
      'clients_type': clientsType, // Added property
      'clients_id': clientsId, // Added property
      'debts_total_amount_in_base': debtsTotalAmountInBase,
      'debts_paid_amount_in_base': debtsPaidAmountInBase,
      'debts_amount_currency_id': debtsAmountCurrencyId,
      // 'invoices_number': invoicesNumber,
    };
    map.removeWhere((key, value) => value == null || value == "");
    return map;
  }
}
