import 'dart:io';

import 'package:path_provider/path_provider.dart';

// The main function to log the error
Future<void> logErrorToFile(dynamic error, StackTrace? stackTrace) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    // We'll create a file named 'app_errors.txt'
    final file = File('${directory.path}/almonazim_app_errors.txt');

    final now = DateTime.now();

    // Format the error message and stack trace
    final formattedLog = '''
--- Error Log ---
Timestamp: $now
Error: $error
Stack Trace:
$stackTrace
-----------------
''';

    // Append the log to the file
    // The 'mode: FileMode.append' is crucial to not overwrite previous logs.
    await file.writeAsString(formattedLog, mode: FileMode.append);
  } catch (e) {
    // If saving the log file fails for some reason, you should handle it gracefully.
    // For example, you can print to the console (which works in debug mode).
    print('Failed to save error log: $e');
  }
}
