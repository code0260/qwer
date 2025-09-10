import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/formatters/formatter.dart';
import 'package:almonazim/core/helper/printing/invoice%20pdf/get_page_pdf_format_from_setting.dart';
import 'package:almonazim/core/helper/printing/invoice%20pdf/color/invoice_header_with_color.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:almonazim/data/data%20source/locale/store_invoice_pdf_settings.dart';
import 'package:almonazim/data/model/invoice%20models/get_invoices_items_model.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_items_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

TableRow buildColumnsRowColor() {
  return TableRow(
    decoration: const BoxDecoration(color: PdfColors.orange300),
    children: [
      textTableCellColor("الإجمالي", PdfColors.white, isBold: true),
      textTableCellColor("الإفرادي", PdfColors.white, isBold: true),
      textTableCellColor("الكمية", PdfColors.white, isBold: true),
      textTableCellColor("المنتج", PdfColors.white, isBold: true),
      textTableCellColor("رقم", PdfColors.white, isBold: true),
    ],
  );
}

TableRow buildInvoiceItemColor(
    InvoiceItemsModel item, int currencyId, int number) {
  return TableRow(
    decoration: const BoxDecoration(color: PdfColors.white),
    children: [
      textTableCellColor(
          Formatter.formatAmount(
              item.invoicesItemsTotalProductPrice!.toDouble(),
              currencyId: currencyId,
              showSymbol: false),
          PdfColors.blueGrey900),
      textTableCellColor(
          Formatter.formatAmount(item.unitPrice!,
              currencyId: currencyId, showSymbol: false),
          PdfColors.blueGrey900),
      textTableCellColor(
          "${item.invoicesItemsProductsCount!} ${item.unitsSymbol}",
          PdfColors.blueGrey900),
      textTableCellColor(item.productsName!, PdfColors.blueGrey900),
      textTableCellColor(number.toString(), PdfColors.blueGrey900),
    ],
  );
}

// Function to build an invoice page.
// - isFirstPage: determines whether to display the header.
// - isLastPage: determines whether to display the summary.
// - If summaryOnly is false, the page shows the table rows provided.
Page buildInvoicePageColor(
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
          buildInvoiceHeaderColor(logo, invoicesItems),
        if (!summaryOnly)
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(2),
              4: FlexColumnWidth(0.8),
            },
            border: TableBorder.all(color: PdfColors.blueGrey900, width: 0.5),
            children: itemRows,
          ),
        if (isLastPage || summaryOnly) ...[
          SizedBox(height: 6),
          Divider(thickness: 0.5, color: PdfColors.grey),
          buildSummaryColor(invoicesItems, clientBalance, currenciesSymbol),
        ],
        SizedBox(height: 40),
      ],
    ),
  );
}

Widget buildSummaryColor(GetInvoicesItemsModel invoicesItems,
    double? clientBalance, String currencySymbol) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if ((invoicesItems.invoiceModel.invoicesDiscountedAmount! +
              invoicesItems.invoiceModel.invoicesShippingCost!) !=
          invoicesItems.invoiceModel.invoicesUndiscountedAmount!)
        buildSummaryRowColor(
          'سعر المنتجات:',
          Formatter.formatAmount(
            invoicesItems.invoiceModel.invoicesUndiscountedAmount!,
            currencyId: invoicesItems.invoiceModel.invoicesAmountCurrencyId,
            showSymbol: false,
          ),
          currencySymbol,
        ),
      if (invoicesItems.invoiceModel.invoicesShippingCost != 0)
        buildSummaryRowColor(
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
        buildSummaryRowColor(
          'الخصم:',
          '${invoicesItems.invoiceModel.invoicesUndiscountedAmount! - invoicesItems.invoiceModel.invoicesDiscountedAmount!}',
          currencySymbol,
        ),
      buildSummaryRowColor(
        'المجموع:',
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
        buildSummaryRowColor(
          'المدفوع:',
          Formatter.formatAmount(
            invoicesItems.invoiceModel.invoicesPaidAmount!,
            currencyId: invoicesItems.invoiceModel.invoicesAmountCurrencyId,
            showSymbol: false,
          ),
          currencySymbol,
        ),
      if (invoicesItems.invoiceModel.invoicesPaymentStatus != 'paid')
        buildSummaryRowColor(
          valueColor: PdfColors.red,
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
        buildSummaryRowColor(
          valueColor: PdfColors.green,
          'كامل رصيد العميل:',
          getBalanceAmountTextColor(clientBalance, invoicesItems),
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
                color: PdfColors.blueGrey900,
              ),
            ),
            Text(
              "- ${invoicesItems.invoiceModel.invoicesNotes!}",
              style: const TextStyle(fontSize: 9, color: PdfColors.blueGrey900),
            ),
          ],
        ),
      SizedBox(height: 50),
    ],
  );
}

Widget buildSummaryRowColor(
    String leftText, String rightText, String currencySymbol,
    {PdfColor color = PdfColors.blueGrey900,
    PdfColor valueColor = PdfColors.blueGrey900}) {
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
          Text(
            currencySymbol,
            style: TextStyle(fontSize: 9, color: valueColor),
          ),
        ],
      ),
    ],
  );
}

String getBalanceAmountTextColor(
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

Padding textTableCellColor(String text, PdfColor color, {bool isBold = false}) {
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
