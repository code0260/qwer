import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/alert_loading.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/close_loading_dialog.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/my_snack_bar.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/helper/printing/choose_device_dialog.dart';
import 'package:almonazim/core/shared/buttons/apply_button.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:almonazim/cubits/invoice%20cubits/get%20invoice%20items%20cubit/get_invoice_items_cubit.dart';
import 'package:almonazim/cubits/invoice%20cubits/pdf%20invoice%20cubit/pdf_invoice_cubit.dart';
import 'package:almonazim/cubits/invoice%20cubits/print%20invoice%20cubit/print_invoice_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_print_setting.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';
import 'package:almonazim/view/widget/invoice/shared%20invoice/open_invoice_button.dart';
import 'package:almonazim/view/widget/invoice/shared%20invoice/share_invoice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

Future<void> printInvoice(BuildContext context) async {
  printerName == ''
      ? printerName = StorePrintSetting.getDefaultPrinter() ?? ''
      : null;
  if (printerName == '') {
    printerName = await chooseDeviceDialog() ?? "";
  }
  if (printerName != "") {
    var state2 = context.read<GetInvoiceItemsCubit>().state;
    if (state2 is GetInvoiceItemsSuccess) {
      // ignore: use_build_context_synchronously
      context.read<PrintInvoiceCubit>().printInvoice(
          state2.allInvoicesItems.originalInvoiceItems, printerName);
    } else {
      mySnackBar(ToastificationType.warning, "تنبيه", 'لا يوجد بيانات');
    }
  } else {
    mySnackBar(ToastificationType.warning, "تنبيه", "لم يتم الاتصال بالطابعة");
  }
}

void showPrintDialog(BuildContext context, int invoiceId,
    {bool? isDraft = false,
    InvoiceType? invoiceType = InvoiceType.buy,
    required void Function() afterDone}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PrintInvoiceCubit(),
          ),
          BlocProvider(
            create: (context) => PdfInvoiceCubit(),
          ),
          BlocProvider(
            create: (context) =>
                GetInvoiceItemsCubit(getIt.get<InvoiceRepoImpl>())
                  ..getInvoiceItems(invoiceId,
                      isDraft: isDraft, invoiceType: invoiceType),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<PrintInvoiceCubit, PrintInvoiceState>(
              listener: (context, state) {
                if (state is PrintInvoiceLoading) {
                  alertLoading();
                } else if (state is PrintInvoiceFailure) {
                  closeLoadingDialog();
                  mySnackBar(
                      ToastificationType.error, "خطأ", state.errorMessage);
                } else if (state is PrintInvoiceSuccess) {
                  closeLoadingDialog();
                  Get.back();
                  Get.back(result: true);
                  mySnackBar(ToastificationType.success, "نجاح",
                      "تم حفظ و طباعة الفاتورة بنجاح");
                }
              },
            ),
            BlocListener<PdfInvoiceCubit, PdfInvoiceState>(
              listener: (context, state) {
                if (state is PdfInvoiceLoading) {
                  alertLoading();
                } else if (state is PdfInvoiceFailure) {
                  closeLoadingDialog();
                  mySnackBar(
                      ToastificationType.error, "خطأ", state.errorMessage);
                } else if (state is PdfInvoiceSuccess) {
                  closeLoadingDialog();
                }
              },
            ),
            BlocListener<GetInvoiceItemsCubit, GetInvoiceItemsState>(
              listener: (context, state) {
                if (state is GetInvoiceItemsLoading) {
                  alertLoading(); // Show loading while printing
                } else if (state is GetInvoiceItemsFailure) {
                  closeLoadingDialog();
                  afterDone.call();
                  mySnackBar(
                      ToastificationType.error, "خطأ", state.errorMessage);
                } else if (state is GetInvoiceItemsSuccess) {}
              },
            ),
          ],
          child: Builder(builder: (context) {
            return AlertDialog(
              title: const Row(
                children: [
                  Text('طباعة'),
                  Spacer(),
                  OpenInvoiceButton(),
                  ShareInvoiceButton()
                ],
              ),
              content:
                  // const Text('هل تريد طباعة الفاتورة أم الاستمرار بدون طباعة؟'),
                  const PopScope(
                      canPop: false,
                      child: Text('الفاتورة جاهزة, شاركها, افتحها أو اطبعها')),
              actions: [
                ApplyButton(
                  title: 'بدون طباعة',
                  onPressed: () {
                    afterDone.call();
                    mySnackBar(
                        ToastificationType.success, 'نجاح', 'تم حفظ الفاتورة ');
                  },
                ),
                CustomButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  title: "طباعة",
                  color: AppColor.primaryColor,
                  onPressed: () async {
                    // context.read<GetInvoiceItemsCubit>().getInvoiceItems(
                    //     invoiceId,
                    //     isDraft: isDraft,
                    //     invoiceType: invoiceType);

                    printInvoice(context);
                  },
                ),
              ],
            );
          }),
        ),
      );
    },
  );
}
