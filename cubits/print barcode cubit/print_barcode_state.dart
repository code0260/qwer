// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'print_barcode_cubit.dart';

sealed class PrintBarcodeState extends Equatable {
  const PrintBarcodeState();

  @override
  List<Object> get props => [];
}

final class PrintBarcodeInitial extends PrintBarcodeState {}

class PrintBarcodeLoading extends PrintBarcodeState {}

class PrintBarcodeFailure extends PrintBarcodeState {
  final String errorMessage;

  const PrintBarcodeFailure({required this.errorMessage});
}

class PrintBarcodeSuccess extends PrintBarcodeState {}

class PrintBarcodeChoose extends PrintBarcodeState {
  final String barcode;
  const PrintBarcodeChoose({
    required this.barcode,
  });
}
