import 'package:almonazim/data/model/client%20models/client_input_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_clients.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/clients%20repo/client_repo_imp.dart';
import 'package:almonazim/data/model/client%20models/client_model.dart';

part 'get_client_state.dart';

class GetClientCubit extends SafeCubit<GetClientState> {
  GetClientCubit(this.clientRepo) : super(GetClientInitial());
  ClientRepoImpl clientRepo;
  Future<void> getClient(ClientType clientType) async {
    emit(GetClientLoading());
    Either<Failure, List<ClientModel>> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      result = await StoreClients.getClients(clientType.name);
    } else {
      result = await clientRepo
          .getClients(ClientInputModel(clientsType: clientType.name));
    }
    result.fold((failure) {
      emit(GetClientFailure(failure.errMessage));
    }, (clients) {
      emit(GetClientSuccess(clients: clients));
    });
  }

  Future<void> refreshAllClients() async {
    emit(GetClientLoading());
    var result = await clientRepo.getAllClients();
    result.fold((failure) {
      emit(GetClientFailure(failure.errMessage));
    }, (clients) {
      emit(GetClientSuccess(clients: clients));
    });
  }
}
