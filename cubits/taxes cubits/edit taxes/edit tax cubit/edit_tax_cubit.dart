import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/taxes%20repo/taxes_repo.dart';
import 'package:almonazim/data/model/taxes%20models/taxes_input_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_tax_state.dart';

class EditTaxCubit extends SafeCubit<EditTaxState> {
  EditTaxCubit(this.taxRepo) : super(EditTaxInitial());
  TaxesRepo taxRepo;
  TaxesInputModel taxInputModel = TaxesInputModel();
  Future<void> editTax() async {
    emit(EditTaxLoading());
    var result = await taxRepo.editTax(taxInputModel);
    result.fold((failure) {
      emit(EditTaxFailure(failure.errMessage));
    }, (_) {
      emit(EditTaxSuccess());
    });
  }

  String? get validateTaxDataMessage {
    if (taxInputModel.taxesName == null || taxInputModel.taxesName!.isEmpty) {
      return "الرجاء إدخال اسم الضريبة";
    } else if (taxInputModel.taxesType == null ||
        taxInputModel.taxesType!.isEmpty) {
      return "الرجاء اختيار نوع الضريبة";
    } else if (taxInputModel.taxesRate == null ||
        taxInputModel.taxesRate!.isEmpty) {
      return "الرجاء إدخال نسبة الضريبة";
    } else if (taxInputModel.taxesIsActive == null) {
      return "الرجاء تحديد حالة الضريبة (فعال أو غير فعال)";
    } else {
      return null; // All fields are valid
    }
  }
}
