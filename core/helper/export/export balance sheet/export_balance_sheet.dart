import 'dart:io';

import 'package:almonazim/core/formatters/formatter.dart';
import 'package:almonazim/core/helper/printing/pdf_generator.dart';
import 'package:almonazim/data/model/account%20models/account_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ExportBalanceSheet {
  // A helper function to build the title and header of the PDF.
  static pw.Widget _buildHeader(String title) {
    return pw.Container(
      alignment: pw.Alignment.center,
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Text(
        title, // Balance Sheet
        style: pw.TextStyle(
          fontSize: 24,
          fontWeight: pw.FontWeight.bold,
        ),
        // Right-to-left for Arabic
      ),
    );
  }

  // A helper function to build a section title (e.g., 'Assets')
  static pw.Widget _buildSectionHeader(String title) {
    return pw.Container(
      margin: const pw.EdgeInsets.symmetric(vertical: 10),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 18,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  // A helper function to build a line item in the balance sheet.
  // It indents based on the account level and shows the name and balance.
  static pw.Widget _buildLine(AccountModel account, double indentation) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(right: indentation),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            account.accountsName ?? '',
            style: account.accountsLevel == 2
                ? pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)
                : null,
          ),
          pw.Text(
            Formatter.formatAmount(account.accountsBalance ?? 0.0,
                showSymbol: false),
            style: account.accountsLevel == 2
                ? pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)
                : null,
          ),
        ],
      ),
    );
  }

  // A helper function to build a total line for a section.
  static pw.Widget _buildTotalLine(String title, double total,
      {bool isGrandTotal = false}) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 5),
      padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: isGrandTotal
          ? pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 2),
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(5)),
            )
          : null,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            Formatter.formatAmount(total, showSymbol: false),
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // A revised helper function to build a section of the balance sheet.
  static pw.Widget _buildSectionContent(List<AccountModel> sectionAccounts) {
    final List<pw.Widget> widgets = [];

    // Filter for top-level accounts (those without a parent ID in this list)
    final topLevelAccounts = sectionAccounts
        .where((a) =>
            !sectionAccounts.any((b) => b.accountsId == a.accountsParentId))
        .toList();

    // Sort accounts to maintain a consistent order.
    topLevelAccounts
        .sort((a, b) => (a.accountsCode ?? '').compareTo(b.accountsCode ?? ''));

    // Iterate over the top-level accounts to build the hierarchy
    for (var topLevelAccount in topLevelAccounts) {
      // Add the section header for the top-level account.
      widgets.add(_buildSectionHeader(topLevelAccount.accountsName ?? ''));

      // Find and add direct children (first level of indentation).
      final children = sectionAccounts
          .where((a) => a.accountsParentId == topLevelAccount.accountsId)
          .toList();

      for (var child in children) {
        widgets.add(_buildLine(child, 10));

        // Find and add sub-accounts of the children (second level of indentation).
        final subAccounts = sectionAccounts
            .where((a) => a.accountsParentId == child.accountsId)
            .toList();

        for (var subAccount in subAccounts) {
          widgets.add(_buildLine(subAccount, 20));
        }
      }
    }

    // Calculate the total for the section.
    final totalBalance = sectionAccounts.fold(
        0.0, (sum, item) => sum + (item.accountsBalance ?? 0.0));

    // Add the section total line.
    widgets.add(pw.SizedBox(height: 10));
    if (topLevelAccounts.first.accountsLevel != 1) {
      widgets.add(_buildTotalLine(
        'مجموع ${topLevelAccounts.first.accountsName}',
        totalBalance,
      ));
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: widgets,
    );
  }

  // The main function to generate the PDF file.
  static Future<File> generatePdf(List<AccountModel> accounts) async {
    final pdf = pw.Document();

    // Filter accounts to only include Balance Sheet items.
    final balanceSheetAccounts = accounts
        .where((a) =>
            a.accountsStatement == 'Balance Sheet' && a.accountsBalance != 0)
        .toList();

    // Separate assets and liabilities/equity.
    final assets =
        balanceSheetAccounts.where((a) => a.accountsNature == 'Debit').toList();
    final liabilitiesAndEquity = balanceSheetAccounts
        .where((a) => a.accountsNature == 'Credit')
        .toList();

    // Calculate grand totals for both sides
    final totalAssets = assets.fold(0.0, (sum, item) {
      if (item.accountsLevel == 4) {
        return sum + (item.accountsBalance ?? 0.0);
      } else {
        return sum;
      }
    });
    var totalLiabilitiesAndEquity = liabilitiesAndEquity.fold(0.0, (sum, item) {
      if (item.accountsLevel == 4) {
        return sum + (item.accountsBalance ?? 0.0);
      } else {
        return sum;
      }
    });

    //$ profit and loss show
    liabilitiesAndEquity.add(AccountModel(
        accountsId: -10,
        accountsNature: 'Credit',
        accountsName: 'الأرباح/الخسائر',
        accountsCode: '212',
        accountsLevel: 3,
        accountsIsSub: 1,
        accountsParentId: liabilitiesAndEquity
            .firstWhere(
              (element) => element.accountsCode == '21',
            )
            .accountsId,
        accountsBalance: totalAssets - totalLiabilitiesAndEquity));
    totalLiabilitiesAndEquity += (totalAssets - totalLiabilitiesAndEquity);

    // Add a page to the PDF document
    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(
            base: PdfGenerator.normalFont, bold: PdfGenerator.boldFont),
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) {
          // Check if there are any accounts to display.
          if (assets.isEmpty && liabilitiesAndEquity.isEmpty) {
            return pw.Center(
              child: pw.Text(
                'لا توجد بيانات متاحة للميزانية العمومية.',
                style: pw.TextStyle(fontSize: 16),
              ),
            );
          }

          return pw.Column(
            // crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              // Header: Balance Sheet Title
              _buildHeader('الميزانية العمومية'),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text("بتاريخ ", style: pw.TextStyle(fontSize: 18)),
                    pw.Text(DateTime.now().toString().substring(0, 10),
                        style: pw.TextStyle(fontSize: 18)),
                  ]),
              pw.SizedBox(height: 10),

              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  // The section header is now built inside the _buildSectionContent function
                  _buildSectionContent(assets),
                ],
              ),
              _buildTotalLine('مجموع الأصول', totalAssets, isGrandTotal: true),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  // The section header is now built inside the _buildSectionContent function
                  _buildSectionContent(liabilitiesAndEquity),
                ],
              ),
              _buildTotalLine(
                  'مجموع الالتزامات وحقوق الملكية', totalLiabilitiesAndEquity,
                  isGrandTotal: true),
              pw.SizedBox(height: 20),

              // // Main content: Two columns for Assets and Liabilities/Equity
              // pw.Row(
              //   crossAxisAlignment: pw.CrossAxisAlignment.start,
              //   children: [
              //     // Assets Section (left column)
              //     pw.Expanded(
              //       child: pw.Column(
              //         crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              //         children: [
              //           // The section header is now built inside the _buildSectionContent function
              //           _buildSectionContent(assets),
              //         ],
              //       ),
              //     ),
              //     pw.SizedBox(width: 20),

              //     // Liabilities and Equity Section (right column)
              //     pw.Expanded(
              //       child: pw.Column(
              //         crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              //         children: [
              //           // The section header is now built inside the _buildSectionContent function
              //           _buildSectionContent(liabilitiesAndEquity),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // pw.SizedBox(height: 20),

              // // Grand Totals at the bottom
              // pw.Row(
              //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              //   children: [
              //     pw.Expanded(
              //       child: _buildTotalLine('مجموع الأصول', totalAssets,
              //           isGrandTotal: true),
              //     ),
              //     pw.SizedBox(width: 20),
              //     pw.Expanded(
              //       child: _buildTotalLine('مجموع الالتزامات وحقوق الملكية',
              //           totalLiabilitiesAndEquity,
              //           isGrandTotal: true),
              //     ),
              //   ],
              // ),
            ],
          );
        },
      ),
    );

    // This is a placeholder for saving the file, you will need to implement this
    // based on your application's needs (e.g., using path_provider for mobile).
    return PdfGenerator.savePdf(
      name: "الميزانية".replaceAll(' ', '_'),
      pdf: pdf,
    );
  }
}
