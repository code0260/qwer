import 'package:almonazim/core/helper/functions/get_payment_state.dart';
import 'package:almonazim/core/helper/functions/invoice%20functions/translate_invoice_type.dart';
import 'package:almonazim/data/data%20source/locale/store_invoice_pdf_settings.dart';
import 'package:almonazim/data/model/invoice%20models/get_invoices_items_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Widget buildInvoiceHeaderColor(
    Image? logo, GetInvoicesItemsModel invoicesItems) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (logo != null)
        Center(
          child: Container(
            alignment: Alignment.topCenter,
            height: 120,
            child: logo,
          ),
        ),
      if (StoreInvoicePdfSettings.getInvoicePdfSettings()!.showTitle)
        Center(
          child: Text(
            StoreUserModel.instance.businessName!,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: PdfColors.blueGrey900,
            ),
          ),
        ),
      SizedBox(height: 8),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildRowTextColor('رقم الفاتورة:',
                    invoicesItems.invoiceModel.invoicesNumber!),
                buildRowTextColor(
                  'نوع الفاتورة:',
                  translateToArInvoiceTypeFromString(
                      invoicesItems.invoiceModel.invoicesType!),
                ),
                buildRowTextColor(
                  'العميل:',
                  invoicesItems.invoiceModel.clientsName ??
                      invoicesItems.invoiceModel.partnersName ??
                      'غير معروف',
                ),
              ],
            ),
          ),
          SizedBox(width: 30),
          // Right column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildRowTextColor(
                    'التاريخ:',
                    invoicesItems.invoiceModel.invoicesAppliedAt!
                        .substring(0, 10)),
                buildRowTextColor(
                    'الوقت:',
                    Jiffy.parse(invoicesItems.invoiceModel.invoicesCreatedAt!)
                        .jm),
                buildRowTextColor(
                  'حالة الدفع:',
                  getPaymentState(
                      invoicesItems.invoiceModel.invoicesPaymentStatus!),
                ),
              ],
            ),
          ),
        ],
      ),
      Divider(thickness: 0.5, color: PdfColors.grey),
      SizedBox(height: 5),
    ],
  );
}

Widget buildRowTextColor(String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: PdfColors.blueGrey900)),
        SizedBox(width: 4),
        Flexible(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 9, color: PdfColors.blueGrey900))),
      ],
    ),
  );
}
