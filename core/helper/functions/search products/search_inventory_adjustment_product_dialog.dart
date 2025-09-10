import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/constant/app_design_endpoint.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/alert_exit_cart.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:almonazim/core/shared/search_cart_text_field.dart';
import 'package:almonazim/cubits/cart%20inventory%20adjustment%20cubit/add%20inventory%20adjustment%20cart%20cubit/edit_search_inventory_adjustment_cart_cubit.dart';
import 'package:almonazim/cubits/cart%20inventory%20adjustment%20cubit/view%20inventory%20adjustment%20cart%20cubit/view_inventory_adjustment_cart_cubit.dart';
import 'package:almonazim/cubits/search%20cubits/e%20search%20cubits/search%20inventory%20adjustment%20cubit/search_inventory_adjustment_product_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo_imp.dart';
import 'package:almonazim/view/widget/search/e search/shared/search_products_grid_shimmer.dart';
import 'package:almonazim/view/widget/search/e%20search/sell/search_products_inventory_adjustment_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Future<void> onCancelPressed() async {
  if (cartInventoryAdjustmentSearch.isEmpty) {
    Get.back();
  } else {
    bool shouldExit = await alertExitCartScreen();
    if (shouldExit) {
      cartInventoryAdjustmentSearch.clear();
      searchInventoryAdjustmentData.clear();
      Get.back(); // Exit the screen
    }
  }
}

Future<dynamic> searchInventoryAdjustmentProductDialog(BuildContext context,
    ViewInventoryAdjustmentCartCubit viewInventoryAdjustmentCartCubit) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      EditSearchInventoryAdjustmentCartCubit addCartCubit =
          EditSearchInventoryAdjustmentCartCubit();
      TextEditingController searchController = TextEditingController();
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SearchInventoryAdjustmentProductCubit(
                getIt.get<SearchProductRepoImpl>()),
          ),
          BlocProvider(
            create: (context) => addCartCubit,
          ),
        ],
        child: AlertDialog(
          content: Builder(builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 250,
              width: AppDesignEndpoint.isMobile(context)
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width / 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SearchCartTextField(
                      hintText: "ابحث عن منتج...",
                      searchController: searchController,
                      onPressed: () {
                        if (searchController.text.isNotEmpty &&
                            searchController.text.length > 1) {
                          context
                              .read<SearchInventoryAdjustmentProductCubit>()
                              .searchInventoryAdjustmentProduct(
                                  searchController.text.trim()); //
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: (12)),
                  BlocBuilder<SearchInventoryAdjustmentProductCubit,
                      SearchInventoryAdjustmentProductState>(
                    builder: (context, state) {
                      if (state is SearchInventoryAdjustmentProductInitial) {
                        return const Text(
                          "أضف أو ابحث عن  منتج...",
                          textAlign: TextAlign.center,
                          // style: TextStyle(fontSize: 18),
                        );
                      } else if (state
                          is SearchInventoryAdjustmentProductLoading) {
                        return const SearchProductsGridShimmer();
                      } else if (state
                          is SearchInventoryAdjustmentProductFailure) {
                        return Text(
                          state.errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(),
                        );
                      } else {
                        var products =
                            (state as SearchInventoryAdjustmentProductSuccess)
                                .products;
                        if (products.isEmpty) {
                          return const Text('المنتج موجود بالسلة بالفعل',
                              textAlign: TextAlign.center);
                        }
                        return SearchProductsInventoryAdjustmentGrid(
                            editSearchBuyCartCubit: addCartCubit,
                            products: products);
                      }
                    },
                  )
                ],
              ),
            );
          }),
          actions: [
            Builder(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    title: "إلغاء",
                    style: TextStyle(color: AppColor.whiteMainReverse),
                    color: Theme.of(context).dialogTheme.backgroundColor,
                    onPressed: () async {
                      await onCancelPressed();
                    },
                    shadow: 0,
                  ),
                  BlocBuilder<EditSearchInventoryAdjustmentCartCubit,
                      EditSearchInventoryAdjustmentCartState>(
                    builder: (context, state) {
                      return CustomButton(
                        title: "تأكيد",
                        color: AppColor.primaryColor,
                        onPressed: cartInventoryAdjustmentSearch.isEmpty
                            ? null
                            : () {
                                viewInventoryAdjustmentCartCubit
                                    .viewInventoryAdjustmentCartAfterSearch();
                                Get.back();
                              },
                      );
                    },
                  ),
                ],
              );
            }),
          ],
        ),
      );
    },
  );
}
