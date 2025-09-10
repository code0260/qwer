// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:almonazim/core/constant/app_enums.dart';
import 'package:flutter/foundation.dart';

class FilterModel {
  List<InvoiceType> invoiceType;
  DateTime? startDate;
  DateTime? endDate;
  int? clientsId;
  int? partnerId;
  String? paymentState;
  String? notes;
  bool? isCompletedDebt;
  DateTime? startDateSecond; // Added property
  DateTime? endDateSecond; // Added property
  int? productId;

  FilterModel({
    required this.invoiceType,
    this.startDate,
    this.partnerId,
    this.productId,
    this.endDate,
    this.clientsId,
    this.paymentState,
    this.notes,
    this.isCompletedDebt,
    this.startDateSecond, // Added property
    this.endDateSecond, // Added property
  });

  Map<String, dynamic> toServer() {
    Map<String, dynamic> map = {
      "invoices_type": invoiceType
          .map(
            (e) => e.name,
          )
          .toList(),
      "start_date": startDate?.toUtc().toString().substring(0, 19),
      "end_date": endDate?.toUtc().toString().substring(0, 19),
      "clients_id": clientsId,
      "partners_id": partnerId,
      "products_id": productId,
      "payment_state": paymentState,
      "notes": notes,
      "is_completed_debt": isCompletedDebt,
      "start_date_second": startDateSecond
          ?.toUtc()
          .toString()
          .substring(0, 19), // Added property to server
      "end_date_second": endDateSecond
          ?.toUtc()
          .toString()
          .substring(0, 19), // Added property to server
    };
    map.removeWhere(
        (key, value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  String toJson() {
    return jsonEncode(toServer());
  }

  @override
  bool operator ==(covariant FilterModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.invoiceType, invoiceType) &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.clientsId == clientsId &&
        other.productId == productId &&
        other.partnerId == partnerId &&
        other.paymentState == paymentState &&
        other.notes == notes &&
        other.isCompletedDebt == isCompletedDebt &&
        other.startDateSecond == startDateSecond &&
        other.endDateSecond == endDateSecond;
  }

  @override
  int get hashCode {
    return invoiceType.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        clientsId.hashCode ^
        productId.hashCode ^
        partnerId.hashCode ^
        notes.hashCode ^
        paymentState.hashCode ^
        isCompletedDebt.hashCode ^
        startDateSecond.hashCode ^
        endDateSecond.hashCode;
  }
}
