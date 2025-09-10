import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/settings%20repo/settings_repo.dart';
import 'package:almonazim/data/model/settings%20models/settings_model.dart';
import 'package:equatable/equatable.dart';

part 'get_settings_state.dart';

class GetSettingsCubit extends SafeCubit<GetSettingsState> {
  GetSettingsCubit(this.settingsRepo) : super(GetSettingsInitial());
  SettingsRepo settingsRepo;
  String key = '';
  Future<void> getSettings(String settingKey) async {
    key = settingKey;
    emit(GetSettingsLoading());
    var result = await settingsRepo.getSetting(settingKey);
    result.fold((failure) {
      emit(GetSettingsFailure(failure.errMessage));
    }, (settingModel) {
      emit(GetSettingsSuccess(settingModel: settingModel));
    });
  }
}
