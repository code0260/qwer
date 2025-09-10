import 'dart:io';

import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/constant/app_design_endpoint.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/helper/functions/scanner%20functions/show_floating_scanner.dart';
import 'package:almonazim/core/shared/search_text_field.dart';
import 'package:almonazim/cubits/search%20cubits/cubit/search_product_cubit.dart';
import 'package:almonazim/data/data%20source/repo/search%20repo/search%20product%20repo/search_product_repo_imp.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:almonazim/view/widget/search/search/search_products_grid_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Future<ProductModel?> showSearchProductDialog(BuildContext context) async {
  final searchController = TextEditingController();
  bool barcodeHasFocus = false;

  return await showDialog<ProductModel?>(
    context: context,
    builder: (context) {
      return BlocProvider(
        create: (context) =>
            SearchProductCubit(getIt.get<SearchProductRepoImpl>()),
        child: Builder(builder: (context) {
          final searchCubit = context.read<SearchProductCubit>();

          return Dialog(
            insetPadding: const EdgeInsets.all(12),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: AppDesignEndpoint.isMobile(context)
                  ? MediaQuery.of(context).size.width / 1.2
                  : MediaQuery.of(context).size.width / 1.2,
              child: Container(
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(maxHeight: 600),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.adaptive.arrow_back),
                        ),
                        Expanded(
                          child: BarcodeKeyboardListener(
                            useKeyDownEvent: true,
                            onBarcodeScanned: (barcode) {
                              if (!barcodeHasFocus && barcode.isNotEmpty) {
                                searchCubit.productInputModel.productsName =
                                    null;
                                searchCubit.productInputModel.productsBarcode =
                                    barcode;
                                searchCubit.searchProduct();
                              }
                            },
                            child: SearchTextField(
                              onFocusChanged: (hasFocus) {
                                barcodeHasFocus = hasFocus;
                              },
                              additionalIcon:
                                  Platform.isWindows ? null : Icons.qr_code,
                              additionalIconPressed: Platform.isWindows
                                  ? null
                                  : () {
                                      OverlayEntry? overlayEntry;
                                      overlayEntry = showFloatingScanner(
                                        context: context,
                                        overlayEntry: overlayEntry,
                                        onRemove: () {},
                                        onScan: (scannedCode) {
                                          searchCubit.productInputModel
                                              .productsName = null;
                                          searchCubit.productInputModel
                                              .productsBarcode = scannedCode;
                                          searchCubit.searchProduct();
                                          removeFloatingWidget(overlayEntry);
                                        },
                                      );
                                    },
                              hintText: "ابحث عن منتج...",
                              searchController: searchController,
                              fillColor: AppColor.backgroundWhiteBlackSame,
                              onPressed: () {
                                if (searchController.text.isNotEmpty &&
                                    searchController.text.length > 1) {
                                  searchCubit.productInputModel.productsName =
                                      searchController.text.trim();
                                  searchCubit
                                      .productInputModel.productsBarcode = null;
                                  searchCubit.searchProduct();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child:
                          BlocBuilder<SearchProductCubit, SearchProductState>(
                        builder: (context, state) {
                          if (state is SearchProductInitial) {
                            return const Center(
                              child: Text("ابدأ بالبحث الآن 😉😉",
                                  style: TextStyle(fontSize: 16)),
                            );
                          } else if (state is SearchProductLoading) {
                            return const SearchProductsGridShimmer();
                          } else if (state is SearchProductFailure) {
                            return Center(
                              child: Text(state.errorMessage,
                                  style: const TextStyle(fontSize: 16)),
                            );
                          } else {
                            List<ProductModel> products =
                                (state as SearchProductSuccess).products;
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              if (products.length == 1) {
                                Get.back(result: products[0]);
                              }
                            });
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 230,
                                      childAspectRatio: 0.8),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final item = products[index];
                                return InkWell(
                                  onTap: () {
                                    Get.back(result: item);
                                  },
                                  child: SizedBox(
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 4),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          item.productsName ?? '',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    },
  );
}
