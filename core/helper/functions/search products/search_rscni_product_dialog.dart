import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/constant/app_design_endpoint.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/alert_exit_cart.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:almonazim/core/shared/search_cart_text_field.dart';
import 'package:almonazim/cubits/refund%20cubits/cart%20rscni%20cubit/add%20rscni%20cart%20cubit/edit_search_rscni_cart_cubit.dart';
import 'package:almonazim/cubits/refund%20cubits/cart%20rscni%20cubit/view%20rscni%20cart%20cubit/view_rscni_cart_cubit.dart';
import 'package:almonazim/cubits/search%20cubits/e%20search%20cubits/search%20rscni%20cubit/search_rscni_product_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo_imp.dart';
import 'package:almonazim/view/widget/search/e search/rscni/search_products_rscni_grid.dart';
import 'package:almonazim/view/widget/search/e search/shared/search_products_grid_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Future<void> onCancelPressed() async {
  if (rSCNISearch.isEmpty) {
    Get.back();
  } else {
    bool shouldExit = await alertExitCartScreen();
    if (shouldExit) {
      rSCNISearch.clear();
      searchRSCNIData.clear();
      Get.back(); // Exit the screen
    }
  }
}

Future<dynamic> searchRSCNIProductDialog(
    BuildContext context, ViewRSCNICartCubit viewRSCNICartCubit) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      EditSearchRSCNICartCubit addCartCubit = EditSearchRSCNICartCubit();
      TextEditingController searchController = TextEditingController();
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                SearchRSCNIProductCubit(getIt.get<SearchProductRepoImpl>()),
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
                              .read<SearchRSCNIProductCubit>()
                              .searchRSCNIProduct(
                                  searchController.text.trim()); // for buying
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: (12)),
                  BlocBuilder<SearchRSCNIProductCubit, SearchRSCNIProductState>(
                    builder: (context, state) {
                      if (state is SearchRSCNIProductInitial) {
                        return const Text(
                          "أضف أو ابحث عن  منتج...",
                          textAlign: TextAlign.center,
                        );
                      } else if (state is SearchRSCNIProductLoading) {
                        return const SearchProductsGridShimmer();
                      } else if (state is SearchRSCNIProductFailure) {
                        return Text(
                          state.errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(),
                        );
                      } else {
                        var products =
                            (state as SearchRSCNIProductSuccess).products;
                        if (products.isEmpty) {
                          return const Text('المنتج موجود بالسلة بالفعل',
                              textAlign: TextAlign.center);
                        }
                        return SearchRSCNIProductsRSCNIGrid(
                            editSearchRSCNICartCubit: addCartCubit,
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
                  BlocBuilder<EditSearchRSCNICartCubit,
                      EditSearchRSCNICartState>(
                    builder: (context, state) {
                      return CustomButton(
                        title: "تأكيد",
                        color: AppColor.primaryColor,
                        onPressed: rSCNISearch.isEmpty
                            ? null
                            : () {
                                viewRSCNICartCubit.viewRSCNICartAfterSearch();
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
