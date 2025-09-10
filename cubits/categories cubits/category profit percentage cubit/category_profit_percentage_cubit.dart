import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/categories%20repo/categories_repo.dart';
import 'package:equatable/equatable.dart';

part 'category_profit_percentage_state.dart';

class CategoryProfitPercentageCubit
    extends SafeCubit<CategoryProfitPercentageState> {
  CategoryProfitPercentageCubit(this.categoriesRepo)
      : super(CategoryProfitPercentageInitial());
  CategoriesRepo categoriesRepo;
  List<int> categoriesIds = [];
  int? percentage;
  Future<void> editCategoryPercentage() async {
    emit(CategoryProfitPercentageLoading());
    var result = await categoriesRepo.editCategoryProfitPercentage(
        categoriesIds, percentage);
    result.fold((failure) {
      emit(CategoryProfitPercentageFailure(failure.errMessage));
    }, (_) {
      emit(const CategoryProfitPercentageSuccess());
    });
  }
}
