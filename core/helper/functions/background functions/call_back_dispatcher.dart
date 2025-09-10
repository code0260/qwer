// import 'package:almonazim/core/constant/app_background_tasks.dart';
// import 'package:almonazim/core/helper/functions/invoice%20functions/upload_all_invoices.dart';
// import 'package:almonazim/core/helper/functions/other%20functions/refresh_offline_data.dart';
// import 'package:almonazim/core/services/init%20services/init_services.dart';
// import 'package:workmanager/workmanager.dart';

// //TODO: working on a seperate isolate
// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     await InitServices.initBackgroundData();
//     if (task == AppBackgroundTasks.refreshOfflineDataName) {
//       await refreshOfflineData();
//     } else if (task == AppBackgroundTasks.uploadInvoicesName) {
//       await uploadAllInvoice();
//     }

//     return Future.value(true);
//   });
// }
