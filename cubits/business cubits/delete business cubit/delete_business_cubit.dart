import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/business%20repo/business_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'delete_business_state.dart';

class DeleteBusinessCubit extends SafeCubit<DeleteBusinessState> {
  DeleteBusinessCubit(this.businessRepo) : super(DeleteBusinessInitial());
  BusinessRepoImpl businessRepo;

  Future<void> deleteBusiness() async {
    emit(DeleteBusinessLoading());
    var result = await businessRepo.deleteBusiness();
    result.fold((failure) {
      emit(DeleteBusinessFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(const DeleteBusinessSuccess());
    });
  }
}
