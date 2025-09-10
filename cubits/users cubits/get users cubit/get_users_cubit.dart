import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/user%20repo/user_repo_imp.dart';
import 'package:almonazim/data/model/user%20models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'get_users_state.dart';

class GetUsersCubit extends SafeCubit<GetUsersState> {
  GetUsersCubit(this.userRepo) : super(GetUsersInitial());
  UserRepoImpl userRepo;

  Future<void> getUsers() async {
    emit(GetUsersLoading());
    Either<Failure, List<UserModel>> result = await userRepo.getUsers();
    result.fold((failure) {
      emit(GetUsersFailure(failure.errMessage));
    }, (users) {
      emit(GetUsersSuccess(users: users));
    });
  }
}
