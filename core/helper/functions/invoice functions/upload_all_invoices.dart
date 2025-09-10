import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/is_there_offline_invoices.dart';
import 'package:almonazim/data/data%20source/repo/invoice%20repo/invoice_repo_imp.dart';

Future<void> uploadAllInvoice() async {
  if (await isThereOfflineInvoices(invoiceType: InvoiceType.buy)) {
    var buyResult = await getIt.get<InvoiceRepoImpl>().uploadAllBuyInvoices();
    if (buyResult.isRight()) {
      var sellResult =
          await getIt.get<InvoiceRepoImpl>().uploadAllSellInvoices();
      if (sellResult.isRight()) {}
    }
  } else if (await isThereOfflineInvoices(invoiceType: InvoiceType.sell)) {
    var sellResult = await getIt.get<InvoiceRepoImpl>().uploadAllSellInvoices();
    if (sellResult.isRight()) {}
  }
}
