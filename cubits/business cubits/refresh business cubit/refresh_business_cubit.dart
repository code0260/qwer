import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/helper/image_generator.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/business%20repo/business_repo_imp.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:equatable/equatable.dart';

part 'refresh_business_state.dart';

class RefreshBusinessCubit extends SafeCubit<RefreshBusinessState> {
  RefreshBusinessCubit(this.businessRepo) : super(RefreshBusinessInitial());
  BusinessRepoImpl businessRepo;
  Future<void> refreshBusiness() async {
    emit(RefreshBusinessLoading());
    var result = await businessRepo.getBusinessData();
    result.fold((failure) {
      emit(RefreshBusinessFailure(failure.errMessage));
    }, (_) async {
      if (StoreUserModel.instance.businessImage != null) {
        await ImageGenerator.downloadAndSaveImage(
            "${AppLinks.imageLogoLink}/${StoreUserModel.instance.businessImage!}",
            StoreUserModel.instance.businessImage!);
        emit(RefreshBusinessSuccess());
      }
    });
  }
}
