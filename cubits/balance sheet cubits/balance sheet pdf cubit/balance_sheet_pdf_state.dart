part of 'balance_sheet_pdf_cubit.dart';

sealed class BalanceSheetPdfState extends Equatable {
  const BalanceSheetPdfState();

  @override
  List<Object> get props => [];
}

final class BalanceSheetPdfInitial extends BalanceSheetPdfState {}

class BalanceSheetPdfLoading extends BalanceSheetPdfState {}

class BalanceSheetPdfFailure extends BalanceSheetPdfState {
  final String errorMessage;

  const BalanceSheetPdfFailure({required this.errorMessage});
}

class BalanceSheetPdfSuccess extends BalanceSheetPdfState {
  final String? path;

  const BalanceSheetPdfSuccess({this.path});
}
