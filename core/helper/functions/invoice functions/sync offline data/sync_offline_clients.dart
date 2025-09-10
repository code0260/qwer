import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_clients.dart';
import 'package:almonazim/data/data%20source/repo/clients%20repo/client_repo_imp.dart';
import 'package:almonazim/data/model/client%20models/client_input_model.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';

Future<int?> syncOfflineClients(InvoiceModel invoiceModel) async {
  // Fetch all offline clients
  var result = await StoreClients.getOfflineClients();
  return result.fold(
    (failure) => throw Exception(failure.errMessage),
    (offlineClients) async {
      if (offlineClients.isNotEmpty) {
        // Convert offline clients to input models
        List<ClientInputModel> clientsToSend =
            offlineClients.map((clientModel) {
          return ClientInputModel(
            clientsId: clientModel.clientsId,
            clientsName: clientModel.clientsName,
            clientsType: clientModel.clientsType,
            clientsEmail: clientModel.clientsEmail,
            clientsPhoneNumber: clientModel.clientsPhoneNumber,
            clientsAddress: clientModel.clientsAddress,
            clientsCreatedAt: clientModel.clientsCreatedAt,
            clientsBusinessId: clientModel.clientsBusinessId,
          );
        }).toList();

        // Send clients to the server
        var response =
            await getIt.get<ClientRepoImpl>().addMultipleClient(clientsToSend);

        return response.fold(
          (failure) =>
              throw Exception("فشل في مزامنة العملاء: ${failure.errMessage}"),
          (idMap) async {
            // Update local database with new IDs
            for (var clientModel in offlineClients) {
              int originalId = clientModel.clientsId!;
              String? newId = idMap["$originalId"];
              if (newId != null) {
                await StoreClients.updateClientId(originalId, newId.toInt());
              }
            }
            var clientId =
                idMap["${invoiceModel.invoicesClientId!}"] as String?;
            return (clientId)?.toInt();
          },
        );
      }
      return null;
    },
  );
}
