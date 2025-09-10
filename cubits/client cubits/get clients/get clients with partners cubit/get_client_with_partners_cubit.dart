import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_clients.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/clients%20repo/client_repo_imp.dart';
import 'package:almonazim/data/model/client%20models/client_model.dart';

part 'get_client_with_partners_state.dart';

class GetClientsWithPartnersCubit
    extends SafeCubit<GetClientsWithPartnersState> {
  GetClientsWithPartnersCubit(this.clientRepo)
      : super(GetClientsWithPartnersInitial());
  ClientRepoImpl clientRepo;
  Future<void> getClientsWithPartners(ClientType clientType) async {
    emit(GetClientsWithPartnersLoading());
    Either<Failure, List<ClientModel>> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      result = await StoreClients.getClientsAndPartners(clientType.name);
    } else {
      result = await clientRepo.getClientsWithPartners(clientType);
    }
    result.fold((failure) {
      emit(GetClientsWithPartnersFailure(failure.errMessage));
    }, (clientsWithPartners) {
      emit(GetClientsWithPartnersSuccess(
          clientsWithPartners: clientsWithPartners));
    });
  }
}
