import 'dart:io';

import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/formatters/formatter.dart';
import 'package:almonazim/core/helper/functions/client%20report%20functions/translate_client_deal_type.dart';
import 'package:almonazim/core/helper/functions/get_business_logo.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:almonazim/data/model/client%20models/client_model.dart';
import 'package:almonazim/data/model/report%20models/client%20report%20models/client_account_statement_model.dart';
import 'package:almonazim/data/model/report%20models/client%20report%20models/client_account_statement_summary_model.dart';
import 'package:almonazim/data/model/report%20models/client%20report%20models/client_deal_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw; // Using the 'pw' prefix for clarity

class ExportClientAccountStatement {
  static Future<File> generatePdf(ClientAccountStatementModel accountStatement,
      String startDate, String endDate) async {
    final pdf = pw.Document();
    final pw.Image? logo = await getBusinessLogoImage();

    // The entire document is now a single MultiPage widget.
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: PdfGenerator.normalFont,
          bold: PdfGenerator.boldFont,
        ),

        // Add a footer to display the page numbers on every page
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            margin: const pw.EdgeInsets.only(top: 10),
            child: pw.Text(
              '${context.pageNumber}/${context.pagesCount}',
              style: const pw.TextStyle(color: PdfColors.grey),
            ),
          );
        },

        // This is where the entire content of the document is built.
        // The `MultiPage` widget will automatically handle page breaks.
        build: (pw.Context context) {
          return [
            // The document header (logo, title, date range)
            buildStatementHeader(logo, accountStatement, startDate, endDate),

            // The main table with all the deals.
            // All rows are built at once, and the library handles the overflow.
            pw.Table(
              columnWidths: const {
                0: pw.IntrinsicColumnWidth(flex: 1),
                1: pw.IntrinsicColumnWidth(flex: 1),
                2: pw.IntrinsicColumnWidth(flex: 1),
                3: pw.IntrinsicColumnWidth(flex: 1),
                4: pw.IntrinsicColumnWidth(flex: 1),
              },
              border: pw.TableBorder.all(color: PdfColors.black, width: 0.5),
              children: [
                buildDealColumnsRow(), // Table header row
                ...accountStatement.clientDeals
                    .map((deal) => buildDealRow(deal)),
              ],
            ),

            // The summary section is placed after the table.
            // It will naturally be rendered on the last page of the table content.
            buildStatementSummary(
              accountStatement.summaryModel,
              accountStatement.getClientModel.clientModel,
            ),
          ];
        },
      ),
    );

    return PdfGenerator.savePdf(
      name:
          "كشف_حساب_${accountStatement.getClientModel.clientModel.clientsName}"
              .replaceAll(' ', '_'),
      pdf: pdf,
    );
  }

  // --- Helper Widgets (mostly unchanged, with 'pw' prefix added) ---

  static pw.Widget buildStatementHeader(
    pw.Image? logo,
    ClientAccountStatementModel accountStatement,
    String startDate,
    String endDate,
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
                  'كشف حساب ${accountStatement.getClientModel.clientModel.clientsName ?? 'N/A'}',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            pw.Spacer(),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.Text(
              'الفترة:  ',
              style: const pw.TextStyle(fontSize: 15),
            ),
            pw.Text(
              'من ',
              style: const pw.TextStyle(fontSize: 15),
            ),
            pw.Text('    ${(startDate).substring(0, 10)}',
                style: const pw.TextStyle(fontSize: 15),
                textDirection: pw.TextDirection.ltr),
            pw.Text(
              'إلى ',
              style: const pw.TextStyle(fontSize: 15),
            ),
            pw.Text('${(endDate).substring(0, 10)}  ',
                style: const pw.TextStyle(fontSize: 15),
                textDirection: pw.TextDirection.ltr),
          ],
        ),
        pw.Row(children: [
          pw.Text(
            'الرصيد الحالي: ${Formatter.formatAmount(accountStatement.getClientModel.totalBalance, showSymbol: false)}',
            style: const pw.TextStyle(
              fontSize: 15,
            ),
          )
        ]),
        pw.SizedBox(height: 20),
      ],
    );
  }

  static pw.TableRow buildDealColumnsRow() {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey200),
      children: [
        textTableCell("عليه", PdfColors.black, isBold: true),
        textTableCell("له", PdfColors.black, isBold: true),
        textTableCell("الرقم", PdfColors.black, isBold: true),
        textTableCell("نوع المعاملة", PdfColors.black, isBold: true),
        textTableCell("تاريخ المعاملة", PdfColors.black, isBold: true),
      ],
    );
  }

  static pw.TableRow buildDealRow(ClientDealModel deal) {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.white),
      children: [
        textTableCell(
            deal.dealDebtCredit == "Debit"
                ? Formatter.formatAmount(deal.dealAmount ?? 0,
                    showSymbol: false)
                : "0.0",
            PdfColors.black),
        textTableCell(
            deal.dealDebtCredit == "Credit"
                ? Formatter.formatAmount(deal.dealAmount ?? 0,
                    showSymbol: false)
                : "0.0",
            PdfColors.black),
        textTableCell(deal.dealNumber ?? '', PdfColors.black),
        textTableCell(
            translateToArDealTypeFromString(deal.dealType!), PdfColors.black),
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
      ),
    );
  }

  static pw.Widget buildStatementSummary(
      ClientAccountStatementSummaryModel summary, ClientModel clientModel) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        pw.Text(
          'الملخص:',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
        ),
        pw.Divider(thickness: 0.5, color: PdfColors.grey),
        buildSummaryRow(
          'إجمالي له:',
          Formatter.formatAmount(summary.totalCredit ?? 0.0, showSymbol: false),
        ),
        buildSummaryRow(
          'إجمالي عليه:',
          Formatter.formatAmount(summary.totalDebit ?? 0.0, showSymbol: false),
        ),
        buildSummaryRow(
          'الفرق في قيمة الحساب:',
          Formatter.formatAmount(summary.netBalance ?? 0.0, showSymbol: false),
          valueColor: (summary.netBalance ?? 0.0) >= 0
              ? PdfColors.green800
              : PdfColors.red800,
        ),
        pw.SizedBox(height: 30),
        pw.Text(
          'توضيح الحساب',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
        ),
        pw.Divider(thickness: 0.5, color: PdfColors.grey),
        buildSummaryRowDescription(
          'إجمالي عليه',
          clientModel.clientsType == ClientType.customer.name
              ? 'إجمالي عليه هو مجموع المبالغ المستحقة على الزبون.'
              : 'إجمالي عليه هو مجموع المبالغ التي تم دفعها للمورد.',
          Formatter.formatAmount(summary.totalDebit ?? 0.0, showSymbol: false),
          valueColor: PdfColors.red800,
        ),
        pw.SizedBox(height: 5),
        buildSummaryRowDescription(
          'إجمالي له',
          clientModel.clientsType == ClientType.customer.name
              ? 'إجمالي له هو مجموع المبالغ التي دفعها الزبون أو تم تسويتها.'
              : 'إجمالي له هو مجموع المبالغ التي يجب دفعها للمورد.',
          Formatter.formatAmount(summary.totalCredit ?? 0.0, showSymbol: false),
          valueColor: PdfColors.green800,
        ),
        pw.SizedBox(height: 5),
        buildSummaryRowDescription(
          'الفرق في قيمة الحساب',
          'الفرق بين عليه وله.',
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
        ),
      ],
    );
  }
}
