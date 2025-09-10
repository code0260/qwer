import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/general%20repo/general_repo.dart';

part 'get_latest_version_state.dart';

class GetLatestVersionCubit extends SafeCubit<GetLatestVersionState> {
  GetLatestVersionCubit(this.generalRepo) : super(GetLatestVersionInitial());
  GeneralRepo generalRepo;
  Future<void> getLatestVersion() async {
    emit(GetLatestVersionLoading());
    var result = await generalRepo.getLatestVersion();
    result.fold((failure) {
      emit(GetLatestVersionFailure(failure.errMessage));
    }, (latestVersion) {
      emit(GetLatestVersionSuccess(latestVersion: latestVersion));
    });
  }
}
