import 'package:almonazim/core/helper/functions/custom%20dialogs/my_snack_bar.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:almonazim/core/shared/shimmers/text_field_shimmer.dart';
import 'package:almonazim/cubits/currency%20cubits/get%20business%20currency%20cubit/get_business_currency_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/currency%20repo/currency_repo_imp.dart';
import 'package:almonazim/view/widget/currency/business_currencies_drop_down_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

Future<int?> chooseCurrencyDialog(
    {required BuildContext context, int? defaultCurrencyId}) {
  return showDialog<int>(
    context: context,
    builder: (context) {
      return BlocProvider(
        create: (context) =>
            GetBusinessCurrencyCubit(getIt.get<CurrencyRepoImpl>())
              ..getBusinessCurrencies(),
        child: Builder(builder: (context) {
          int currencyId = currencies
              .firstWhere(
                (element) => element.businessCurrencyIsBase == 1,
              )
              .businessCurrencyId!;
          if (defaultCurrencyId != null) {
            currencyId = defaultCurrencyId;
          }
          return AlertDialog(
              title: const Text(
                'اختر العملة',
                textAlign: TextAlign.center,
              ),
              content: Column(
                children: [
                  BlocBuilder<GetBusinessCurrencyCubit,
                      GetBusinessCurrencyState>(
                    builder: (context, state) {
                      if (state is GetBusinessCurrencyLoading) {
                        return const TextFieldShimmer();
                      } else if (state is GetBusinessCurrencyFailure) {
                        return Text(state.errorMessage);
                      } else {
                        return BusinessCurrenciesDropDownSearch(
                          defaultCurrencyId: currencyId,
                          onGotId: (id) {
                            currencyId = id;
                          },
                          currencies:
                              (state as GetBusinessCurrencySuccess).currencies,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  CustomButton(
                      onPressed: () {
                        if (defaultCurrencyId == currencyId) {
                          mySnackBar(ToastificationType.error, 'خطأ',
                              'الرجاء اختيار عملة أخرى مختلفة عن العملة الموجودة');
                        } else {
                          Get.back(result: currencyId);
                        }
                      },
                      title: 'تم')
                ],
              ));
        }),
      );
    },
  );
}
