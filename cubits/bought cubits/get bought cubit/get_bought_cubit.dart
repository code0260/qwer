import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/bought%20repo/bought_repo_imp.dart';
import 'package:almonazim/data/model/bought%20models/bought_info_input_model.dart';
import 'package:almonazim/data/model/bought%20models/bought_info_model.dart';
import 'package:equatable/equatable.dart';

part 'get_bought_state.dart';

class GetBoughtCubit extends SafeCubit<GetBoughtState> {
  GetBoughtCubit(this.boughtRepo) : super(GetBoughtInitial());
  BoughtRepoImpl boughtRepo;
  BoughtInfoInputModel boughtInfoInputModel = BoughtInfoInputModel();
  Future<void> getBoughtInfo() async {
    emit(GetBoughtLoading());
    var result = await boughtRepo.getBoughtInfo(boughtInfoInputModel);
    result.fold((failure) {
      emit(GetBoughtFailure(failure.errMessage));
    }, (boughtInfoInputModel) {
      emit(GetBoughtSuccess(boughtInfoModel: boughtInfoInputModel));
    });
  }
}
