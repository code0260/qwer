import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_clients.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/clients%20repo/client_repo.dart';
import 'package:almonazim/data/model/client%20models/client_input_model.dart';
import 'package:almonazim/data/model/client%20models/client_model.dart';
import 'package:almonazim/data/model/client%20models/get_client_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:dartz/dartz.dart';

class ClientRepoImpl implements ClientRepo {
  final ApiService apiService;
  ClientRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ClientModel>>> getClients(
      ClientInputModel clientInputModel) async {
    final result = await apiService.post(
      url: AppLinks.getClientsLink,
      formDataIsEnabled: false,
      data: clientInputModel.toMap(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<ClientModel> clientsLocale = [];
        for (final client in response["data"]) {
          clientsLocale.add(ClientModel.fromJson(client));
        }
        //! clients[clientsType]!
        //!     .add(const ClientModel(clientsName: "غير معروف", clientsId: 0));
        return right(clientsLocale);
      },
    );
  }

  @override
  Future<Either<Failure, List<GetClientModel>>> getClientsBalance(
      ClientInputModel clientInputModel) async {
    final result = await apiService.post(
        url: AppLinks.getClientsBalanceLink,
        formDataIsEnabled: false,
        data: clientInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<GetClientModel> clientsLocale = [];
        for (final client in response["data"]) {
          clientsLocale.add(GetClientModel.fromJson(client));
        }
        return right(clientsLocale);
      },
    );
  }

  @override
  Future<Either<Failure, GetClientModel>> getClientBalanceById(
      int clientsId) async {
    final result = await apiService.post(
      url: AppLinks.getClientBalanceByIdLink,
      data: {'clients_id': clientsId},
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(GetClientModel.fromJson(response["data"][0]));
      },
    );
  }

  @override
  Future<Either<Failure, List<ClientModel>>> getClientsWithPartners(
      ClientType clientsType) async {
    final result = await apiService.post(
      url: AppLinks.getClientsWithPartnersLink,
      data: {
        "clients_type": clientsType.name,
      },
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<ClientModel> clientsLocale = [];
        for (final client in response["data"]) {
          clientsLocale.add(ClientModel.fromJson(client));
        }
        return right(clientsLocale);
      },
    );
  }

  @override
  Future<Either<Failure, int>> addClient(
      ClientInputModel clientInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addClientLink,
        data: clientInputModel.toDatabaseMap());

    return result.fold(
      (failure) => left(failure),
      (response) async {
        clientInputModel.clientsId = (response['data'] as String).toInt();
        clientInputModel.clientsBusinessId =
            StoreUserModel.instance.businessId!;
        clientInputModel.clientsOnline = 1;
        var insertClientResult =
            await StoreClients.insertClient(clientInputModel.toDatabaseMap());
        return insertClientResult.fold(
            (l) => right(clientInputModel.clientsId!),
            (r) => right(clientInputModel.clientsId!));
      },
    );
  }

  @override
  Future<Either<Failure, void>> importClients(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importClientsLink,
        requestName: "clients_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("14");
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editClient(
      ClientInputModel clientInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.editClientLink,
        data: clientInputModel.toDatabaseMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, Map>> addMultipleClient(
      List<ClientInputModel> clients) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addMultipleClientLink,
        data: {
          "clients": clients
              .map(
                (clientModel) => clientModel.toDatabaseMap(),
              )
              .toList()
        });

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response["data"]);
      },
    );
  }

  @override
  Future<Either<Failure, List<ClientModel>>> getAllClients() async {
    final result = await apiService.get(url: AppLinks.getAllClientsLink);

    return result.fold(
      (failure) => left(failure),
      (response) async {
        List<int> clientIds = [];
        List<ClientModel> clientsLocale = [];
        for (final client in response["data"]) {
          clientIds.add(client['clients_id']);
          await StoreClients.updateClientData(client);
          clientsLocale.add(ClientModel.fromJson(client));
        }
        await StoreClients.deleteClientsViaIdList(clientIds);

        return right(clientsLocale);
      },
    );
  }
}
