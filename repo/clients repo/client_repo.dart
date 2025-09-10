import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/client%20models/client_input_model.dart';
import 'package:almonazim/data/model/client%20models/client_model.dart';
import 'package:almonazim/data/model/client%20models/get_client_model.dart';
import 'package:dartz/dartz.dart';

abstract class ClientRepo {
  Future<Either<Failure, List<ClientModel>>> getClients(
      ClientInputModel clientInputModel);
  Future<Either<Failure, List<ClientModel>>> getAllClients();

  Future<Either<Failure, List<GetClientModel>>> getClientsBalance(
      ClientInputModel clientInputModel);
  Future<Either<Failure, GetClientModel>> getClientBalanceById(int clientsId);
  Future<Either<Failure, List<ClientModel>>> getClientsWithPartners(
      ClientType clientsType);
  Future<Either<Failure, void>> importClients(String filePath);
  Future<Either<Failure, void>> addClient(ClientInputModel clientInputModel);
  Future<Either<Failure, void>> editClient(ClientInputModel clientInputModel);
  Future<Either<Failure, Map>> addMultipleClient(
      List<ClientInputModel> clients);
}
