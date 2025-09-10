import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_products.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/product%20repo/product_repo.dart';
import 'package:almonazim/data/model/price%20models/prices_input_model.dart';
import 'package:almonazim/data/model/product%20models/add_product_model.dart';
import 'package:almonazim/data/model/product%20models/product_input_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'add_product_state.dart';

class AddProductCubit extends SafeCubit<AddProductState> {
  AddProductCubit(this.productRepo) : super(AddProductInitial());

  ProductsRepo productRepo;
  AddProductModel addProductModel = AddProductModel(
      buyPriceModel: PriceInputModel(),
      sellPriceModel: PriceInputModel(),
      productInputModel: ProductInputModel());

  // Add Product Function
  Future<void> addProduct() async {
    emit(AddProductLoading());
    Either<Failure, dynamic> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      addProductModel.productInputModel.productsOnline = 0;
      addProductModel.productInputModel.productsBusinessId =
          StoreUserModel.instance.businessId!;
      result = await StoreProducts.insertProduct(
          addProductModel.productInputModel.toMap());
    } else {
      result = await productRepo.addProduct(addProductModel);
    }

    result.fold(
      (failure) {
        emit(AddProductFailure(failure.errMessage));
      },
      (_) {
        emit(const AddProductSuccess());
      },
    );
  }

  // Data Validation Logic
  String? get validateDataMessage {
    if (addProductModel.productInputModel.productsName == null ||
        addProductModel.productInputModel.productsName!.isEmpty) {
      return "الرجاء إدخال اسم المنتج";
    } else if (addProductModel.productInputModel.productsBaseUnitId == null) {
      return "الرجاء اختيار واحدة القياس الأساسية للمنتج";
    } else if (addProductModel.productInputModel.productsCategories == null) {
      return "الرجاء اختيار فئة المنتج";
    } else if (addProductModel.productInputModel.productsType == null) {
      return "الرجاء اختيار نوغ المنتج";
    } else {
      return null;
    }
  }
}
