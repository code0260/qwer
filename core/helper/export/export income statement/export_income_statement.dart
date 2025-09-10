import 'dart:io';

import 'package:almonazim/core/formatters/formatter.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart'; // Assuming this is your utility for saving
import 'package:almonazim/data/model/report%20models/income%20statement%20report%20models/income_statement_line_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class ExportIncomeStatement {
  static Future<File> generatePdf(
      List<IncomeStatementLineModel>
          linesData, // Renamed to linesData to avoid conflict
      String startDate,
      String endDate) async {
    final pdf = Document();

    // including the calculated totals.
    List<Widget> pdfLines = [];

    // Helper function to find a line by account code safely
    IncomeStatementLineModel findLineByCode(
        List<IncomeStatementLineModel> list, String code) {
      try {
        return list.firstWhere((element) => element.accountCode == code);
      } catch (e) {
        // Handle case where account code is not found, return a dummy line
        print(
            'Warning: Account code $code not found in income statement data.');
        return IncomeStatementLineModel(
          accountName: 'غير متوفر ($code)',
          total: 0.0,
          accountCode: code,
        );
      }
    }

    // Extract necessary lines from the provided data
    final revenues = findLineByCode(linesData, '41'); // إيرادات النشاط
    final cogs = findLineByCode(linesData, '31'); // تكلفة الإيرادات
    final generalExpenses =
        findLineByCode(linesData, '32'); // مصاريف إدارية وعمومية
    final marketingExpenses =
        findLineByCode(linesData, '33'); // مصاريف بيعية وتسويقية
    final otherExpenses =
        findLineByCode(linesData, '34'); // مصروفات أخرى متنوعة
    final otherRevenues = findLineByCode(linesData, '42'); // إيرادات أخرى

    // --- Calculations ---
    final num grossProfit = (revenues.total ?? 0.0) - (cogs.total ?? 0.0);
    final num operatingIncome = grossProfit -
        ((generalExpenses.total ?? 0.0) + (marketingExpenses.total ?? 0.0));
    final num netProfit = operatingIncome +
        ((otherRevenues.total ?? 0.0) - (otherExpenses.total ?? 0.0));

    // --- Build the PDF content list ---

    // Section: Revenues and Cost of Goods Sold
    pdfLines.add(_buildSectionHeader(
        'الإيرادات وتكلفة البضاعة المباعة')); // New section header
    pdfLines.add(
        _buildLineWidget(revenues.copyWith(accountName: 'إيرادات النشاط')));
    pdfLines
        .add(_buildLineWidget(cogs.copyWith(accountName: 'تكلفة الإيرادات')));
    pdfLines.add(_buildSumLineWidget(
      amount: grossProfit.toDouble(),
      percentage: (grossProfit / revenues.total!) * 100,
      descriptionPositive: 'مجمل الربح',
      descriptionNegative: 'مجمل الخسارة',
      // percentage: (revenues.total != 0) ? (grossProfit / revenues.total!) * 100 : 0.0, // Only if you want to show percentage
    ));
    pdfLines.add(SizedBox(height: 15)); // Spacing between sections

    // Section: Operating Expenses
    pdfLines
        .add(_buildSectionHeader('المصاريف التشغيلية')); // New section header
    pdfLines.add(_buildLineWidget(
        generalExpenses.copyWith(accountName: 'مصاريف إدارية وعمومية')));
    pdfLines.add(_buildLineWidget(
        marketingExpenses.copyWith(accountName: 'مصاريف بيعية وتسويقية')));
    pdfLines.add(_buildSumLineWidget(
      amount: operatingIncome.toDouble(),
      percentage: (operatingIncome / revenues.total!) * 100,
      descriptionPositive: 'الربح من العمليات',
      descriptionNegative: 'الخسارة من العمليات',
      // percentage: (revenues.total != 0) ? (operatingIncome / revenues.total!) * 100 : 0.0,
    ));
    pdfLines.add(SizedBox(height: 15)); // Spacing between sections

    // Section: Other Income and Expenses
    pdfLines
        .add(_buildSectionHeader('إيرادات ومصاريف أخرى')); // New section header
    pdfLines.add(_buildLineWidget(
        otherExpenses.copyWith(accountName: 'مصروفات أخرى متنوعة')));
    pdfLines.add(
        _buildLineWidget(otherRevenues.copyWith(accountName: 'إيرادات أخرى')));
    pdfLines.add(_buildSumLineWidget(
      amount: netProfit.toDouble(),
      percentage: (netProfit / revenues.total!) * 100,
      descriptionPositive: 'صافي الربح',
      descriptionNegative: 'صافي الخسارة',
      // percentage: (revenues.total != 0) ? (netProfit / revenues.total!) * 100 : 0.0,
    ));

    // Add the page to the PDF document
    pdf.addPage(
      Page(
        theme: ThemeData.withFont(
            base: PdfGenerator.normalFont, bold: PdfGenerator.boldFont),
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header: Income Statement Title and Dates
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'قائمة الدخل', // Income Statement
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    // font: arabicFont, // Uncomment if you loaded an Arabic font
                  ),
                  textDirection: TextDirection.rtl, // Right-to-left for Arabic
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text(
                      endDate.substring(0, 10), // From: startDate
                      style: const TextStyle(fontSize: 14),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      '  إلى:  ', // From: startDate
                      style: const TextStyle(fontSize: 14),
                      textDirection: TextDirection.rtl,
                    ),
                  ]),
                  Row(children: [
                    Text(
                      startDate.substring(0, 10), // From: startDate
                      style: const TextStyle(fontSize: 14),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      '  من:  ', // From: startDate
                      style: const TextStyle(fontSize: 14),
                      textDirection: TextDirection.rtl,
                    ),
                  ])
                ],
              ),
              SizedBox(height: 20),

              // Dynamically generated income statement lines
              // This uses the list of widgets built above
              ...pdfLines,

              Spacer(), // Pushes content to the top

              // Footer (optional)
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'تم إنشائه بواسطة تطبيق المنظم للمحاسبة.', // A more appropriate footer
                  textDirection: TextDirection.rtl,

                  style: const TextStyle(fontSize: 10, color: PdfColors.grey),
                ),
              ),
            ],
          );
        },
      ),
    );

    // Save the PDF using your utility function
    return PdfGenerator.savePdf(
      name:
          "قائمة_الدخل${" من ${startDate.toString().substring(0, 10)} إلى ${endDate.toString().substring(0, 10)}".replaceAll(' ', '_')}",
      pdf: pdf,
    );
  }

  // --- Helper Widgets for PDF Layout ---

  // Builds a standard income statement line
  static Widget _buildLineWidget(IncomeStatementLineModel line) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Amount (Left Aligned for numbers)
          Text(
            Formatter.formatAmount(line.total!), // Format as currency
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 14,

              fontWeight: FontWeight.bold,
              color: (line.total ?? 0) < 0
                  ? PdfColors.red
                  : PdfColors.black, // Red for negative
            ),
          ),
          // Description (Right Aligned for Arabic text)
          Text(
            line.accountName ?? '', // Use accountName for description
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              // font: arabicFont, // Uncomment if you loaded an Arabic font
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  // Builds a summary line (Gross Profit/Loss, Operating Profit/Loss, Net Profit/Loss)
  static Widget _buildSumLineWidget({
    required double amount,
    required double percentage,
    required String descriptionPositive,
    required String descriptionNegative,
    // double? percentage, // Optional: if you want to display percentage
  }) {
    final String description =
        amount >= 0 ? descriptionPositive : descriptionNegative;
    final PdfColor textColor = amount >= 0 ? PdfColors.green : PdfColors.red;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: PdfColors.black, width: 1),
          bottom: BorderSide(color: PdfColors.black, width: 1),
        ),
        color: PdfColors.grey100, // Slightly different background for totals
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Formatter.formatAmount(
                amount), // Show absolute value, color indicates sign
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Row(children: [
            if (amount > 0 && percentage > 0)
              Text(
                "(${percentage.toStringAsFixed(2)}%)",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.black,
                  // font: arabicFont, // Uncomment if you loaded an Arabic font
                ),
                textDirection: TextDirection.rtl,
              ),
            SizedBox(width: 5),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: PdfColors.black,
                // font: arabicFont, // Uncomment if you loaded an Arabic font
              ),
              textDirection: TextDirection.rtl,
            ),
          ])
        ],
      ),
    );
  }

  // Builds a section header (e.g., "الإيرادات وتكلفة البضاعة المباعة")
  static Widget _buildSectionHeader(String title) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: PdfColors.orange100, // Light grey background for headers
            border: Border.all(color: PdfColors.grey),
            borderRadius: BorderRadius.circular(5), // Slightly rounded corners
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Align text to the right for Arabic
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 10), // Padding from right edge
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: PdfColors.black, // A distinct color for headers
                    // font: arabicFont, // Uncomment if you loaded an Arabic font
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
