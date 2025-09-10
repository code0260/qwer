import 'dart:io';

import 'package:excel/excel.dart';

// A helper function to convert an XLSX file to CSV in Flutter.
Future<String> convertXlsxToCsv(String inputFilePath) async {
  // Read the XLSX file bytes.
  final fileBytes = File(inputFilePath).readAsBytesSync();

  // Load the Excel file from the bytes.
  final excel = Excel.decodeBytes(fileBytes);

  // Get the first sheet's name. You can loop through all sheets if needed.
  final sheetName = excel.getDefaultSheet() ?? excel.sheets.keys.first;
  final sheet = excel.sheets[sheetName];

  if (sheet == null) {
    throw Exception('No sheets found in the Excel file.');
  }

  // Create the CSV content string.
  final csvContent = StringBuffer();
  for (final row in sheet.rows) {
    // Join the cells in the row with a comma.
    final rowData = row.map((cell) => cell?.value?.toString() ?? '').join(',');
    csvContent.writeln(rowData);
  }

  // Create the output file path.
  final newPath = inputFilePath.replaceAll('.xlsx', '.csv');

  // Write the CSV content to the new file.
  final outputFile = File(newPath);
  await outputFile.writeAsString(csvContent.toString());

  return newPath;
}
