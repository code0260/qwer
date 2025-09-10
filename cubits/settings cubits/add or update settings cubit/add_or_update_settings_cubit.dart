import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/settings%20repo/settings_repo.dart';
import 'package:equatable/equatable.dart';

part 'add_or_update_settings_state.dart';

class AddOrUpdateSettingsCubit extends SafeCubit<AddOrUpdateSettingsState> {
  AddOrUpdateSettingsCubit(this.settingsRepo)
      : super(AddOrUpdateSettingsInitial());
  SettingsRepo settingsRepo;
  Future<void> addOrUpdateSetting(String key, String value) async {
    emit(AddOrUpdateSettingsLoading());
    var result = await settingsRepo.addOrUpdateSetting(key, value);
    result.fold((failure) {
      emit(AddOrUpdateSettingsFailure(failure.errMessage));
    }, (_) {
      emit(const AddOrUpdateSettingsSuccess());
    });
  }
}
