import 'dart:io';

import 'package:almonazim/core/formatters/formatter.dart';
import 'package:almonazim/core/helper/functions/cash%20functions/cash%20report%20functions/translate_cash_deals.dart';
import 'package:almonazim/core/helper/functions/get_business_logo.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/report%20models/cash%20report%20models/cash_account_statement_model.dart';
import 'package:almonazim/data/model/report%20models/cash%20report%20models/cash_account_statement_summary_model.dart';
import 'package:almonazim/data/model/report%20models/cash%20report%20models/cash_deal_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw; // Use the pw alias

class ExportCashStatement {
  static Future<File> generatePdf(
    CashAccountStatementModel model,
    String startDate,
    String endDate,
  ) async {
    final pdf = pw.Document();
    final pw.Image? logo = await getBusinessLogoImage();

    const String cashAccountName = 'الأساسي';

    // The main content of the PDF is now a single MultiPage widget.
    // The library will automatically create new pages as the content overflows.
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl, // Apply RTL to the whole document
        theme: pw.ThemeData.withFont(
          base: PdfGenerator.normalFont,
          bold: PdfGenerator.boldFont,
        ),

        // This header will appear on the first page only because it's
        // placed at the beginning of the `build` list.
        // It's a static widget, not a repeating header.
        // If you want a repeating header, you would use the `header` callback.

        // This footer will appear on every page with page numbers.
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 10),
            child: pw.Text(
              '${context.pageNumber}/${context.pagesCount}',
              style: const pw.TextStyle(color: PdfColors.grey),
            ),
          );
        },

        // The build method contains the entire document content.
        // The `pw.Table` will automatically be split across pages.
        build: (pw.Context context) {
          return [
            // The document header (logo, title, date range)
            buildStatementHeader(
                logo, model, startDate, endDate, cashAccountName),

            // The main table with all the deals.
            // The `pw.MultiPage` widget will automatically break this table
            // and continue it on a new page when it overflows.
            pw.Table(
              columnWidths: const {
                0: pw.FlexColumnWidth(1),
                1: pw.FlexColumnWidth(1),
                2: pw.FlexColumnWidth(2),
                3: pw.FlexColumnWidth(1),
                4: pw.FlexColumnWidth(1.5),
                5: pw.FlexColumnWidth(1.5),
              },
              border: pw.TableBorder.all(color: PdfColors.black, width: 0.5),
              // Build all rows at once. MultiPage handles the overflow.
              children: [
                buildDealColumnsRow(), // The header row for the table
                ...model.cashDeals.map((deal) => buildDealRow(deal)),
              ],
            ),

            // The summary section is placed after the table.
            // It will naturally be rendered on the last page of the table.
            buildStatementSummary(model.summaryModel),
          ];
        },
      ),
    );

    // Save the PDF using your utility function
    return PdfGenerator.savePdf(
      name: "كشف_حساب_الصندوق_${cashAccountName.replaceAll(' ', '_')}",
      pdf: pdf,
    );
  }

  // --- Helper Widgets (Unchanged from original) ---

  static pw.Widget buildStatementHeader(
    pw.Image? logo,
    CashAccountStatementModel model,
    String startDate,
    String endDate,
    String cashAccountName,
  ) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            if (logo != null)
              pw.Container(
                height: 90,
                width: 90,
                child: logo,
              ),
            pw.Spacer(),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'كشف حساب الصندوق $cashAccountName',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textDirection: pw.TextDirection.rtl,
                ),
              ],
            ),
            pw.Spacer(),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Text(
              'الفترة: ',
              style: const pw.TextStyle(fontSize: 15),
              textDirection: pw.TextDirection.rtl,
            ),
            pw.Text(
              'من ',
              style: const pw.TextStyle(fontSize: 15),
              textDirection: pw.TextDirection.rtl,
            ),
            pw.Text(
              (startDate).substring(0, 10),
              style: const pw.TextStyle(fontSize: 15),
              textDirection: pw.TextDirection.ltr,
            ),
            pw.Text(
              ' إلى ',
              style: const pw.TextStyle(fontSize: 15),
              textDirection: pw.TextDirection.rtl,
            ),
            pw.Text(
              (endDate).substring(0, 10),
              style: const pw.TextStyle(fontSize: 15),
              textDirection: pw.TextDirection.ltr,
            ),
          ],
        ),
        pw.SizedBox(height: 5),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(
            children: List.generate(
                model.getCashModel.cash.length,
                (index) => pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                        '${currencies.firstWhere((element) => element.businessCurrencyId == model.getCashModel.cash[index].cashAmountCurrencyId).currenciesNameAr!}: ${Formatter.formatAmount(model.getCashModel.cash[index].cashAmount!, currencyId: model.getCashModel.cash[index].cashAmountCurrencyId, showSymbol: true)}',
                        style: const pw.TextStyle(
                          fontSize: 15,
                        ),
                        textDirection: pw.TextDirection.rtl,
                      ),
                    )),
          ),
        ),
        pw.SizedBox(height: 20),
      ],
    );
  }

  static pw.TableRow buildDealColumnsRow() {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey200),
      children: [
        textTableCell("مقبوضات", PdfColors.black, isBold: true),
        textTableCell("مدفوعات", PdfColors.black, isBold: true),
        textTableCell("الوصف", PdfColors.black, isBold: true),
        textTableCell("الرقم", PdfColors.black, isBold: true),
        textTableCell("نوع المعاملة", PdfColors.black, isBold: true),
        textTableCell("تاريخ المعاملة", PdfColors.black, isBold: true),
      ],
    );
  }

  static pw.TableRow buildDealRow(CashDealModel deal) {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.white),
      children: [
        textTableCell(
            (deal.dealDebtCredit == "Debit"
                ? Formatter.formatAmount(deal.dealAmount ?? 0,
                    showSymbol: false)
                : "0.0"),
            PdfColors.black),
        textTableCell(
            (deal.dealDebtCredit == "Credit"
                ? Formatter.formatAmount(deal.dealAmount ?? 0,
                    showSymbol: false)
                : "0.0"),
            PdfColors.black),
        textTableCell(deal.dealDesc ?? '', PdfColors.black),
        textTableCell(deal.dealNumber ?? '', PdfColors.black),
        textTableCell(translateToArCashDealTypeFromString(deal.dealType!),
            PdfColors.black),
        textTableCell((deal.dealDate)?.substring(0, 10) ?? '', PdfColors.black),
      ],
    );
  }

  static pw.Padding textTableCell(String text, PdfColor color,
      {bool isBold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(3),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
        textDirection: pw.TextDirection.rtl,
      ),
    );
  }

  static pw.Widget buildStatementSummary(
      CashAccountStatementSummaryModel summary) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        pw.Text(
          'الملخص:',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.Divider(thickness: 0.5, color: PdfColors.grey),
        buildSummaryRow(
          'إجمالي المدفوعات:',
          Formatter.formatAmount(summary.totalCredit ?? 0.0, showSymbol: false),
        ),
        buildSummaryRow(
          'إجمالي المقبوضات:',
          Formatter.formatAmount(summary.totalDebit ?? 0.0, showSymbol: false),
        ),
        buildSummaryRow(
          'صافي الرصيد:',
          Formatter.formatAmount(summary.netBalance ?? 0.0, showSymbol: false),
          valueColor: (summary.netBalance ?? 0.0) >= 0
              ? PdfColors.green800
              : PdfColors.red800,
        ),
        pw.SizedBox(height: 30),
        pw.Text(
          'توضيح الحساب',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.Divider(thickness: 0.5, color: PdfColors.grey),
        buildSummaryRowDescription(
          'إجمالي المقبوضات',
          'إجمالي المقبوضات هو مجموع المبالغ التي تم إيداعها في الصندوق.',
          Formatter.formatAmount(summary.totalDebit ?? 0.0, showSymbol: false),
          valueColor: PdfColors.green800,
        ),
        pw.SizedBox(height: 5),
        buildSummaryRowDescription(
          'إجمالي المدفوعات',
          'إجمالي المدفوعات هو مجموع المبالغ التي تم سحبها من الصندوق.',
          Formatter.formatAmount(summary.totalCredit ?? 0.0, showSymbol: false),
          valueColor: PdfColors.red800,
        ),
        pw.SizedBox(height: 5),
        buildSummaryRowDescription(
          'صافي الرصيد',
          'الفرق بين إجمالي المقبوضات وإجمالي المدفوعات.',
          Formatter.formatAmount(summary.netBalance ?? 0.0, showSymbol: false),
          valueColor: (summary.netBalance ?? 0.0) >= 0
              ? PdfColors.green800
              : PdfColors.red800,
        ),
      ],
    );
  }

  static pw.Widget buildSummaryRow(String leftText, String rightText,
      {PdfColor color = PdfColors.black,
      PdfColor valueColor = PdfColors.black}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          leftText,
          style: pw.TextStyle(
              fontSize: 14, fontWeight: pw.FontWeight.bold, color: color),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.Row(
          children: [
            pw.Text(
              rightText,
              style: pw.TextStyle(fontSize: 14, color: valueColor),
            ),
            pw.SizedBox(width: 2),
          ],
        ),
      ],
    );
  }

  static pw.Widget buildSummaryRowDescription(
      String title, String description, String amount,
      {PdfColor valueColor = PdfColors.black}) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              title,
              style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black),
              textDirection: pw.TextDirection.rtl,
            ),
            pw.Row(
              children: [
                pw.Text(
                  amount,
                  style: pw.TextStyle(fontSize: 12, color: valueColor),
                ),
                pw.SizedBox(width: 2),
              ],
            ),
          ],
        ),
        pw.Text(
          description,
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          textDirection: pw.TextDirection.rtl,
        ),
      ],
    );
  }
}
