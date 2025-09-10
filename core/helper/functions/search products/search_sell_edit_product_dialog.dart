import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/constant/app_design_endpoint.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/alert_exit_cart.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:almonazim/core/shared/search_cart_text_field.dart';
import 'package:almonazim/cubits/cart%20sell%20edit%20cubit/add%20sell%20edit%20cart%20cubit/edit_search_sell_edit_cart_cubit.dart';
import 'package:almonazim/cubits/cart%20sell%20edit%20cubit/view%20sell%20edit%20cart%20cubit/view_sell_edit_cart_cubit.dart';
import 'package:almonazim/cubits/search%20cubits/e%20search%20cubits/search%20sell%20edit%20cubit/search_sell_edit_product_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo_imp.dart';
import 'package:almonazim/view/widget/search/e search/sell/search_products_sell_edit_grid.dart';
import 'package:almonazim/view/widget/search/e search/shared/search_products_grid_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Future<void> onCancelPressed() async {
  if (cartSellEditSearch.isEmpty) {
    Get.back();
  } else {
    bool shouldExit = await alertExitCartScreen();
    if (shouldExit) {
      cartSellEditSearch.clear();
      searchSellEditData.clear();
      Get.back(); // Exit the screen
    }
  }
}

Future<dynamic> searchSellEditProductDialog(
    BuildContext context, ViewSellEditCartCubit viewSellEditCartCubit) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      EditSearchSellEditCartCubit addCartCubit = EditSearchSellEditCartCubit();
      TextEditingController searchController = TextEditingController();
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                SearchSellEditProductCubit(getIt.get<SearchProductRepoImpl>()),
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
                              .read<SearchSellEditProductCubit>()
                              .searchSellEditProduct(searchController.text
                                  .trim()); // for SellEditing
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: (12)),
                  BlocBuilder<SearchSellEditProductCubit,
                      SearchSellEditProductState>(
                    builder: (context, state) {
                      if (state is SearchSellEditProductInitial) {
                        return const Text(
                          "أضف أو ابحث عن  منتج...",
                          textAlign: TextAlign.center,
                        );
                      } else if (state is SearchSellEditProductLoading) {
                        return const SearchProductsGridShimmer();
                      } else if (state is SearchSellEditProductFailure) {
                        return Text(
                          state.errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(),
                        );
                      } else {
                        var products =
                            (state as SearchSellEditProductSuccess).products;
                        if (products.isEmpty) {
                          return const Text('المنتج موجود بالسلة بالفعل',
                              textAlign: TextAlign.center);
                        }
                        return SearchProductsSellEditGrid(
                            editSearchSellCartCubit: addCartCubit,
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
                  BlocBuilder<EditSearchSellEditCartCubit,
                      EditSearchSellEditCartState>(
                    builder: (context, state) {
                      return CustomButton(
                        title: "تأكيد",
                        color: AppColor.primaryColor,
                        onPressed: cartBuySearch.isEmpty
                            ? null
                            : () {
                                viewSellEditCartCubit
                                    .viewSellEditCartAfterSearch();
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
