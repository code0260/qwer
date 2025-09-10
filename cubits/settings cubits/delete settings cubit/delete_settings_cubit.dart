import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/settings%20repo/settings_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'delete_settings_state.dart';

class DeleteSettingsCubit extends SafeCubit<DeleteSettingsState> {
  DeleteSettingsCubit(this.settingsRepo) : super(DeleteSettingsInitial());
  SettingsRepoImpl settingsRepo;
  Future<void> deleteSettings(String key) async {
    emit(DeleteSettingsLoading());
    var result = await settingsRepo.deleteSetting(key);
    result.fold((failure) {
      emit(DeleteSettingsFailure(failure.errMessage));
    }, (_) {
      emit(DeleteSettingsSuccess());
    });
  }
}
