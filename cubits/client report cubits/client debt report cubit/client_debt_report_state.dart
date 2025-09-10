part of 'client_debt_report_cubit.dart';

sealed class ClientDebtReportState extends Equatable {
  const ClientDebtReportState();

  @override
  List<Object> get props => [];
}

final class ClientDebtReportInitial extends ClientDebtReportState {}

class ClientDebtReportLoading extends ClientDebtReportState {}

class ClientDebtReportFailure extends ClientDebtReportState {
  final String errorMessage;

  const ClientDebtReportFailure({required this.errorMessage});
}

class ClientDebtReportSuccess extends ClientDebtReportState {}
