import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/formatters/formatter.dart';
import 'package:almonazim/core/helper/printing/invoice%20pdf/get_page_pdf_format_from_setting.dart';
import 'package:almonazim/core/helper/printing/invoice%20pdf/invoice_header.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:almonazim/data/data%20source/locale/store_invoice_pdf_settings.dart';
import 'package:almonazim/data/model/invoice%20models/get_invoices_items_model.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_items_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

TableRow buildColumnsRow() {
  return TableRow(
    decoration: const BoxDecoration(color: PdfColors.grey200),
    children: [
      textTableCell("الإجمالي", PdfColors.black, isBold: true),
      textTableCell("الإفرادي", PdfColors.black, isBold: true),
      textTableCell("الكمية", PdfColors.black, isBold: true),
      textTableCell("المنتج", PdfColors.black, isBold: true),
      textTableCell("رقم", PdfColors.black, isBold: true),
    ],
  );
}

TableRow buildInvoiceItem(InvoiceItemsModel item, int currencyId, int number) {
  return TableRow(
    decoration: const BoxDecoration(color: PdfColors.white),
    children: [
      textTableCell(
          Formatter.formatAmount(
              item.invoicesItemsTotalProductPrice!.toDouble(),
              currencyId: currencyId,
              showSymbol: false),
          PdfColors.black),
      textTableCell(
          Formatter.formatAmount(item.unitPrice!,
              currencyId: currencyId, showSymbol: false),
          PdfColors.black),
      textTableCell("${item.invoicesItemsProductsCount!} ${item.unitsSymbol}",
          PdfColors.black),
      textTableCell(item.productsName!, PdfColors.black),
      textTableCell(number.toString(), PdfColors.black),
    ],
  );
}

Padding textTableCell(String text, PdfColor color, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.all(3),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 9,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}

Widget buildSummary(GetInvoicesItemsModel invoicesItems, double? clientBalance,
    String currencySymbol) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10),
      if ((invoicesItems.invoiceModel.invoicesDiscountedAmount! +
              invoicesItems.invoiceModel.invoicesShippingCost!) !=
          invoicesItems.invoiceModel.invoicesUndiscountedAmount!)
        buildSummaryRow(
          'سعر المنتجات:',
          Formatter.formatAmount(
            invoicesItems.invoiceModel.invoicesUndiscountedAmount!,
            currencyId: invoicesItems.invoiceModel.invoicesAmountCurrencyId,
            showSymbol: false,
          ),
          currencySymbol,
        ),
      if (invoicesItems.invoiceModel.invoicesShippingCost != 0)
        buildSummaryRow(
          'تكلفة التوصيل:',
          Formatter.formatAmount(
            invoicesItems.invoiceModel.invoicesShippingCost!,
            currencyId: invoicesItems.invoiceModel.invoicesAmountCurrencyId,
            showSymbol: false,
          ),
          currencySymbol,
        ),
      if ((invoicesItems.invoiceModel.invoicesUndiscountedAmount! -
              invoicesItems.invoiceModel.invoicesDiscountedAmount!) !=
          0)
        buildSummaryRow(
            'الخصم:',
            invoicesItems.invoiceModel.invoicesDiscountType ==
                    OfferDiscountType.percentage.name
                ? invoicesItems.invoiceModel.invoicesDiscountValue!
                    .toStringAsFixed(2)
                : Formatter.formatAmount(
                    invoicesItems.invoiceModel.invoicesDiscountValue!,
                    currencyId:
                        invoicesItems.invoiceModel.invoicesAmountCurrencyId),
            invoicesItems.invoiceModel.invoicesDiscountType ==
                    OfferDiscountType.percentage.name
                ? "%"
                : currencySymbol),
      if ((invoicesItems.invoiceModel.invoicesUndiscountedAmount! -
              invoicesItems.invoiceModel.invoicesDiscountedAmount!) !=
          0)
        buildSummaryRow(
          'السعر قبل الخصم:',
          Formatter.formatAmount(
            invoicesItems.invoiceModel.invoicesUndiscountedAmount! +
                invoicesItems.invoiceModel.invoicesShippingCost!,
            currencyId: invoicesItems.invoiceModel.invoicesAmountCurrencyId,
            showSymbol: false,
          ),
          currencySymbol,
        ),
      if ((invoicesItems.invoiceModel.invoicesUndiscountedAmount! -
              invoicesItems.invoiceModel.invoicesDiscountedAmount!) !=
          0)
        Divider(thickness: 0.5, color: PdfColors.grey),
      buildSummaryRow(
        (invoicesItems.invoiceModel.invoicesUndiscountedAmount! -
                    invoicesItems.invoiceModel.invoicesDiscountedAmount!) !=
                0
            ? 'السعر بعد الخصم:'
            : 'المجموع',
        Formatter.formatAmount(
          invoicesItems.invoiceModel.invoicesDiscountedAmount! +
              invoicesItems.invoiceModel.invoicesShippingCost!,
          currencyId: invoicesItems.invoiceModel.invoicesAmountCurrencyId,
          showSymbol: false,
        ),
        currencySymbol,
      ),
      if (invoicesItems.invoiceModel.invoicesPaymentStatus != "paid")
        Divider(thickness: 0.5, color: PdfColors.grey),
      if (invoicesItems.invoiceModel.invoicesPaymentStatus != "paid")
        buildSummaryRow(
          'المدفوع:',
          Formatter.formatAmount(
            invoicesItems.invoiceModel.invoicesPaidAmount!,
            currencyId: invoicesItems.invoiceModel.invoicesAmountCurrencyId,
            showSymbol: false,
          ),
          currencySymbol,
        ),
      if (invoicesItems.invoiceModel.invoicesPaymentStatus != 'paid')
        buildSummaryRow(
          'الباقي:',
          Formatter.formatAmount(
            ((invoicesItems.invoiceModel.invoicesDiscountedAmount! +
                    invoicesItems.invoiceModel.invoicesShippingCost!) -
                invoicesItems.invoiceModel.invoicesPaidAmount!),
            currencyId: invoicesItems.invoiceModel.invoicesAmountCurrencyId,
            showSymbol: false,
          ),
          currencySymbol,
        ),
      if (clientBalance != null) ...[
        Divider(thickness: 0.5, color: PdfColors.grey),
        SizedBox(height: 8),
        buildSummaryRow(
          'كامل رصيد العميل:',
          getBalanceAmountText(clientBalance, invoicesItems),
          currencySymbol,
          // valueColor: PdfColors.green800
        ),
      ],
      SizedBox(height: 30),
      if (invoicesItems.invoiceModel.invoicesNotes != null &&
          StoreInvoicePdfSettings.getInvoicePdfSettings()!.showInvoiceNotes)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ملاحظات: ',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: PdfColors.black,
              ),
            ),
            Text(
              "- ${invoicesItems.invoiceModel.invoicesNotes!}",
              style: const TextStyle(fontSize: 9, color: PdfColors.black),
            ),
          ],
        ),
      SizedBox(height: 50),
    ],
  );
}

String getBalanceAmountText(
    double clientsBalance, GetInvoicesItemsModel invoicesItems) {
  var formatAmount = Formatter.formatAmount(
    clientsBalance.abs(),
    currencyId: invoicesItems.invoiceModel.invoicesAmountCurrencyId,
    showSymbol: false,
  );
  if (clientsBalance >= 0) {
    return formatAmount;
  } else {
    return "له   ($formatAmount)";
  }
}

Widget buildSummaryRow(
    String leftText, String rightText, String? currencySymbol,
    {PdfColor color = PdfColors.black, PdfColor valueColor = PdfColors.black}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        leftText,
        style:
            TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: color),
      ),
      Row(
        children: [
          Text(
            rightText,
            style: TextStyle(fontSize: 9, color: valueColor),
          ),
          SizedBox(width: 2),
          if (currencySymbol != null)
            Text(
              currencySymbol,
              style: TextStyle(fontSize: 9, color: valueColor),
            ),
        ],
      ),
    ],
  );
}

// Function to build an invoice page.
// - isFirstPage: determines whether to display the header.
// - isLastPage: determines whether to display the summary.
// - If summaryOnly is false, the page shows the table rows provided.
Page buildInvoicePage(
  Image? logo,
  bool isFirstPage,
  bool isLastPage,
  List<TableRow> itemRows,
  GetInvoicesItemsModel invoicesItems,
  double? clientBalance,
  String currenciesSymbol, {
  bool summaryOnly = false,
}) {
  return Page(
    textDirection: TextDirection.rtl,
    theme: ThemeData.withFont(
        base: PdfGenerator.normalFont, bold: PdfGenerator.boldFont),
    pageFormat: getPdfPageFormatFromSetting(),
    build: (_) => Column(
      children: [
        if (isFirstPage && !summaryOnly)
          buildInvoiceHeader(logo, invoicesItems),
        if (!summaryOnly)
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(2),
              4: FlexColumnWidth(0.8),
            },
            border: TableBorder.all(color: PdfColors.black, width: 0.5),
            children: itemRows,
          ),
        if (isLastPage || summaryOnly) ...[
          SizedBox(height: 6),
          Divider(thickness: 0.5, color: PdfColors.grey),
          buildSummary(invoicesItems, clientBalance, currenciesSymbol),
        ],
        SizedBox(height: 40),
      ],
    ),
  );
}

// Refactored table widget to be reusable
Widget buildInvoiceTable(GetInvoicesItemsModel invoicesItems,
    {required bool includeHeader}) {
  return Table(
    columnWidths: const {
      0: FlexColumnWidth(1.5),
      1: FlexColumnWidth(1.2),
      2: FlexColumnWidth(1.5),
      3: FlexColumnWidth(2),
      4: FlexColumnWidth(0.8),
    },
    border: TableBorder.all(color: PdfColors.black, width: 0.5),
    children: [
      if (includeHeader) buildColumnsRow(),
      ...invoicesItems.items.asMap().entries.map((entry) {
        int index = entry.key;
        InvoiceItemsModel item = entry.value;
        return buildInvoiceItem(
          item,
          invoicesItems.invoiceModel.invoicesAmountCurrencyId!,
          index + 1,
        );
      }),
    ],
  );
}
