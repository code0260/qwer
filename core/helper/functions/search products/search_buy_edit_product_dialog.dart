import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/constant/app_design_endpoint.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/alert_exit_cart.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:almonazim/core/shared/search_cart_text_field.dart';
import 'package:almonazim/cubits/cart%20buy%20edit%20cubit/add%20cart%20cubit/edit_search_buy_edit_cart_cubit.dart';
import 'package:almonazim/cubits/cart%20buy%20edit%20cubit/view%20cart%20cubit/view_buy_edit_cart_cubit.dart';
import 'package:almonazim/cubits/search%20cubits/e%20search%20cubits/search%20buy%20edit%20cubit/search_buy_edit_product_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo_imp.dart';
import 'package:almonazim/view/widget/search/e%20search/buy%20edit/search_products_buy_edit_grid.dart';
import 'package:almonazim/view/widget/search/e%20search/shared/search_products_grid_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Future<void> onCancelPressed() async {
  if (cartBuyEditSearch.isEmpty) {
    Get.back();
  } else {
    bool shouldExit = await alertExitCartScreen();
    if (shouldExit) {
      cartBuyEditSearch.clear();
      searchBuyEditData.clear();
      Get.back(); // Exit the screen
    }
  }
}

Future<dynamic> searchBuyEditProductDialog(
    BuildContext context, ViewBuyEditCartCubit viewBuyEditCartCubit) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      EditSearchBuyEditCartCubit addCartCubit = EditSearchBuyEditCartCubit();
      TextEditingController searchController = TextEditingController();
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                SearchBuyEditProductCubit(getIt.get<SearchProductRepoImpl>()),
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
                              .read<SearchBuyEditProductCubit>()
                              .searchBuyEditProduct(
                                  searchController.text.trim()); // for buying
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: (12)),
                  BlocBuilder<SearchBuyEditProductCubit,
                      SearchBuyEditProductState>(
                    builder: (context, state) {
                      if (state is SearchBuyEditProductInitial) {
                        return const Text(
                          "أضف أو ابحث عن  منتج...",
                          textAlign: TextAlign.center,
                        );
                      } else if (state is SearchBuyEditProductLoading) {
                        return const SearchProductsGridShimmer();
                      } else if (state is SearchBuyEditProductFailure) {
                        return Text(
                          state.errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(),
                        );
                      } else {
                        var products =
                            (state as SearchBuyEditProductSuccess).products;
                        if (products.isEmpty) {
                          return const Text('المنتج موجود بالسلة بالفعل',
                              textAlign: TextAlign.center);
                        }
                        return SearchProductsBuyEditGrid(
                            editSearchBuyEditCartCubit: addCartCubit,
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
                  BlocBuilder<EditSearchBuyEditCartCubit,
                      EditSearchBuyEditCartState>(
                    builder: (context, state) {
                      return CustomButton(
                        title: "تأكيد",
                        color: AppColor.primaryColor,
                        onPressed: cartBuyEditSearch.isEmpty
                            ? null
                            : () {
                                viewBuyEditCartCubit.viewCartAfterSearch();
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
