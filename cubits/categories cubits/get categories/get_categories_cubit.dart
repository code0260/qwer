import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_categories.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/categories%20repo/categories_repo.dart';
import 'package:almonazim/data/model/categories_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends SafeCubit<GetCategoriesState> {
  GetCategoriesCubit(this.categoriesRepo) : super(GetCategoriesInitial());
  CategoriesRepo categoriesRepo;

  Future<void> getCategories() async {
    if (categories.isNotEmpty) {
      emit(GetCategoriesSuccess(categories: categories));
      return;
    }
    emit(GetCategoriesLoading());

    Either<Failure, List<CategoriesModel>> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      result = await StoreCategories.getAllCategories();
    } else {
      result = await categoriesRepo.getCategories();
    }
    result.fold((failure) {
      emit(GetCategoriesFailure(failure.errMessage));
    }, (categories) {
      emit(GetCategoriesSuccess(categories: categories));
    });
  }

  Future<void> refreshCategories() async {
    emit(GetCategoriesLoading());
    var result = await categoriesRepo.refreshCategories();
    result.fold((failure) {
      emit(GetCategoriesFailure(failure.errMessage));
    }, (categories) {
      emit(GetCategoriesSuccess(categories: categories));
    });
  }
}
