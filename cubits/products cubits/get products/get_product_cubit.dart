import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/product%20repo/product_repo.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'get_product_state.dart';

class GetProductCubit extends SafeCubit<GetProductState> {
  GetProductCubit(this.productRepo) : super(GetProductInitial());
  ProductsRepo productRepo;
  ScrollController controller = ScrollController();
  int currentCategory = 1;
  int requestNumber = 0;

  Future<void> getProduct() async {
    addingGridListener();
    if (productsByCategory[currentCategory] == null ||
        productsByCategory[currentCategory]!['requestNumber'] < requestNumber) {
      emit(GetProductLoading());
      var result =
          await productRepo.getProducts(currentCategory, requestNumber);
      result.fold((failure) {
        emit(GetProductFailure(failure.errMessage));
      }, (products) {
        setProductsByCategory(currentCategory, products);
        emit(GetProductSuccess(product: products));
      });
    } else {
      emit(GetProductSuccess(
          product: productsByCategory[currentCategory]!['products']));
    }
  }

  void setProductsByCategory(int category, List<ProductModel> products) {
    if (productsByCategory[category] == null) {
      productsByCategory[category] = {
        "products": products,
        "requestNumber": requestNumber
      };
    } else {
      List<ProductModel> listProducts =
          (productsByCategory[category]!['products'] as List<ProductModel>);
      listProducts.addAll(products);
      productsByCategory[category] = {
        "products": listProducts,
        "requestNumber": requestNumber
      };
    }
  }

  void refresh() async {
    requestNumber = 0;
    productsByCategory.clear();
    getProduct();
  }

  void addingGridListener() async {
    removingGridListener();
    await Future.delayed(const Duration(seconds: 1));
    controller.addListener(onGridScroll);
  }

  void removingGridListener() {
    // ignore: invalid_use_of_protected_member
    if (controller.hasListeners) {
      controller.removeListener(onGridScroll);
    } else {}
  }

  void disposeGridControl() {
    controller.dispose();
  }

  void onGridScroll() {
    if (controller.position.maxScrollExtent == controller.offset) {
      requestNumber += 1;
      getProduct();
    }
  }

  void setCategoryDataCompleted() {
    removingGridListener();
  }

  @override
  Future<void> close() {
    disposeGridControl();
    return super.close();
  }
}
