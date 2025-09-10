import 'dart:io';

import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount.dart';
import 'package:almonazim/core/helper/functions/get_business_logo.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/helper/printing/invoice%20pdf/get_page_pdf_format_from_setting.dart';
import 'package:almonazim/core/helper/printing/invoice%20pdf/invoice_header.dart';
import 'package:almonazim/core/helper/printing/invoice%20pdf/invoice_table.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_invoices.dart';
import 'package:almonazim/data/data%20source/locale/store_invoice_pdf_settings.dart';
import 'package:almonazim/data/data%20source/repo/clients%20repo/client_repo_imp.dart';
import 'package:almonazim/data/model/client%20models/get_client_model.dart';
import 'package:almonazim/data/model/invoice%20models/get_invoices_items_model.dart';
import 'package:pdf/widgets.dart';

class InvoicePdf {
  static Future<File> generateInvoice(GetInvoicesItemsModel invoicesItems,
      {bool immediatePrint = false}) async {
    final pdf = Document();
    Image? logo = await getBusinessLogoImage();
    double? clientBalance =
        await getCurrentBalanceWithOfflineDebts(invoicesItems);

    String currenciesSymbol = currencies
        .firstWhere((element) =>
            element.businessCurrencyId ==
            invoicesItems.invoiceModel.invoicesAmountCurrencyId)
        .currenciesSymbol!;
    if (immediatePrint == true) {
      pdf.addPage(
        Page(
          pageFormat: getPdfPageFormatFromSetting(),
          textDirection: TextDirection.rtl,
          theme: ThemeData.withFont(
            base: PdfGenerator.normalFont,
            bold: PdfGenerator.boldFont,
          ),
          build: (Context context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInvoiceHeader(logo, invoicesItems),
                buildInvoiceTable(invoicesItems, includeHeader: true),
                buildSummary(invoicesItems, clientBalance, currenciesSymbol),
              ],
            );
          },
        ),
      );
    } else {
      int totalItems = invoicesItems.items.length;
      List<Page> pages = [];
      // Case 1: If total items are less than or equal to 12, show all items in one page with header and summary.
      if (totalItems <= 12) {
        List<TableRow> rows = [];
        // Add header row on the first (and only) page
        rows.add(buildColumnsRow());
        for (int i = 0; i < totalItems; i++) {
          rows.add(buildInvoiceItem(
            invoicesItems.items[i],
            invoicesItems.invoiceModel.invoicesAmountCurrencyId!,
            i + 1,
          ));
        }
        // Build one page with header and summary
        pages.add(buildInvoicePage(logo, true, true, rows, invoicesItems,
            clientBalance, currenciesSymbol));
      } else {
        // Case 2: More than 12 items

        // --- First Page: fixed 12 items with header, no summary ---
        List<TableRow> firstPageRows = [];
        firstPageRows.add(buildColumnsRow());
        for (int i = 0; i < 12; i++) {
          firstPageRows.add(buildInvoiceItem(
            invoicesItems.items[i],
            invoicesItems.invoiceModel.invoicesAmountCurrencyId!,
            i + 1,
          ));
        }
        pages.add(buildInvoicePage(logo, true, false, firstPageRows,
            invoicesItems, clientBalance, currenciesSymbol));

        // --- Intermediate and Last Pages ---
        int currentIndex = 12;
        while (currentIndex < totalItems) {
          int itemsRemaining = totalItems - currentIndex;
          int itemsThisPage = itemsRemaining > 20 ? 20 : itemsRemaining;
          bool isLastPage = (itemsRemaining <= 20);

          List<TableRow> pageRows = [];
          // No header on these pages
          for (int i = currentIndex; i < currentIndex + itemsThisPage; i++) {
            pageRows.add(buildInvoiceItem(
              invoicesItems.items[i],
              invoicesItems.invoiceModel.invoicesAmountCurrencyId!,
              i + 1,
            ));
          }
          pages.add(buildInvoicePage(logo, false, isLastPage, pageRows,
              invoicesItems, clientBalance, currenciesSymbol));
          currentIndex += itemsThisPage;
        }
      }

      // Add all pages to PDF
      for (Page page in pages) {
        pdf.addPage(page);
      }
    }
    return PdfGenerator.savePdf(
      name:
          "فاتورة_${(invoicesItems.invoiceModel.clientsName ?? invoicesItems.invoiceModel.partnersName!)}_${(invoicesItems.invoiceModel.invoicesNumber!)}"
              .replaceAll('/', "_")
              .replaceAll(r'\', "_")
              .replaceAll(" ", '_'),
      pdf: pdf,
    );
  }

  static Future<GetClientModel?> getClientBalanceData(
      GetInvoicesItemsModel invoicesItems) async {
    if (invoicesItems.invoiceModel.invoicesClientId != null) {
      var result = await getIt
          .get<ClientRepoImpl>()
          .getClientBalanceById(invoicesItems.invoiceModel.invoicesClientId!);
      return result.fold((l) => null, (r) => r);
    }
    return null;
  }

  static Future<double?> getCurrentBalanceWithOfflineDebts(
      GetInvoicesItemsModel invoicesItems) async {
    if (StoreInvoicePdfSettings.getInvoicePdfSettings()!
            .showTotalBalanceForClient ==
        false) {
      return null;
    }
    GetClientModel? getClientModel;
    double? totalBalance;
    getClientModel = await getClientBalanceData(invoicesItems);
    if (getClientModel == null) {
      return totalBalance;
    } else {
      var result = await StoreInvoices.searchInvoicesByNumber(
          invoicesItems.invoiceModel.invoicesNumber!);
      return result.fold(
        (l) {
          return totalBalance;
        },
        (r) {
          double serverClientBalance = convertAmount(
              getClientModel!.totalBalance,
              currencies
                  .firstWhere((element) => element.businessCurrencyIsBase == 1)
                  .businessCurrencyId!,
              invoicesItems.invoiceModel.invoicesAmountCurrencyId!);
          if (r.isNotEmpty) {
            if (invoicesItems.invoiceModel.invoicesPaymentStatus == 'paid') {
              return serverClientBalance;
            }
            totalBalance =
                ((invoicesItems.invoiceModel.invoicesDiscountedAmount! +
                            invoicesItems.invoiceModel.invoicesShippingCost!) -
                        invoicesItems.invoiceModel.invoicesPaidAmount!) +
                    serverClientBalance;
            return totalBalance;
          } else {
            return serverClientBalance;
          }
        },
      );
    }
  }
}
