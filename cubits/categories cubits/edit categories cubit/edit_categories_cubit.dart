import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/categories%20repo/categories_repo_imp.dart';
import 'package:almonazim/data/model/categories_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_categories_state.dart';

class EditCategoriesCubit extends SafeCubit<EditCategoriesState> {
  EditCategoriesCubit(this.categoriesRepo) : super(EditCategoriesInitial());
  CategoriesRepoImpl categoriesRepo;
  CategoriesModel categoriesModel = CategoriesModel();
  Future<void> editCategory() async {
    emit(EditCategoriesLoading());
    var result = await categoriesRepo.editCategory(categoriesModel);
    result.fold((failure) {
      emit(EditCategoriesFailure(failure.errMessage));
    }, (_) {
      emit(EditCategoriesSuccess());
    });
  }
}
