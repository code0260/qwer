import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/categories%20repo/categories_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'delete_categories_state.dart';

class DeleteCategoriesCubit extends SafeCubit<DeleteCategoriesState> {
  DeleteCategoriesCubit(this.categoriesRepo) : super(DeleteCategoriesInitial());
  CategoriesRepoImpl categoriesRepo;
  Future<void> deleteCategories(int categoryId) async {
    emit(DeleteCategoriesLoading());
    var result = await categoriesRepo.deleteCategory(categoryId);
    result.fold((failure) {
      emit(DeleteCategoriesFailure(failure.errMessage));
    }, (_) {
      emit(DeleteCategoriesSuccess());
    });
  }
}
