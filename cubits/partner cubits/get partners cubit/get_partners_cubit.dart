import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/partners%20repo/partner_repo_imp.dart';
import 'package:almonazim/data/model/partner%20models/partner_model.dart';
import 'package:equatable/equatable.dart';

part 'get_partners_state.dart';

class GetPartnerCubit extends SafeCubit<GetPartnerState> {
  GetPartnerCubit(this.partnerRepo) : super(GetPartnerInitial());
  PartnerRepoImpl partnerRepo;
  Future<void> getPartner() async {
    emit(GetPartnerLoading());
    var result = await partnerRepo.getPartners();
    result.fold((failure) {
      emit(GetPartnerFailure(failure.errMessage));
    }, (partners) {
      emit(GetPartnerSuccess(partners: partners));
    });
  }
}
