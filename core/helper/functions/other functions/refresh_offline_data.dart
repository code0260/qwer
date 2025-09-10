import 'package:almonazim/core/helper/functions/get_offline_data.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/is_there_offline_invoices.dart';

Future<void> refreshOfflineData() async {
  if (!await isThereOfflineInvoices()) {
    await getOfflineData();
  }
}
