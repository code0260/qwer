import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/partners%20repo/partner_repo.dart';
import 'package:almonazim/data/model/partner%20models/partner_input_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_partner_state.dart';

class EditPartnerCubit extends SafeCubit<EditPartnerState> {
  EditPartnerCubit(this.partnerRepo) : super(EditPartnerInitial());
  PartnerRepo partnerRepo;
  PartnerInputModel partnerInputModel = PartnerInputModel();
  Future<void> editPartner() async {
    emit(EditPartnerLoading());
    var result = await partnerRepo.editPartner(partnerInputModel);
    result.fold((failure) {
      emit(EditPartnerFailure(failure.errMessage));
    }, (_) {
      emit(EditPartnerSuccess());
    });
  }
}
