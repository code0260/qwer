import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/categories%20repo/categories_repo.dart';
import 'package:equatable/equatable.dart';

part 'add_categories_state.dart';

class AddCategoriesCubit extends SafeCubit<AddCategoriesState> {
  AddCategoriesCubit(this.categoriesRepo) : super(AddCategoriesInitial());
  CategoriesRepo categoriesRepo;
  Future<void> addCategory(String name) async {
    emit(AddCategoriesLoading());
    var result = await categoriesRepo.addCategory(name);
    result.fold((failure) {
      emit(AddCategoriesFailure(failure.errMessage));
    }, (_) {
      emit(const AddCategoriesSuccess());
    });
  }
}
