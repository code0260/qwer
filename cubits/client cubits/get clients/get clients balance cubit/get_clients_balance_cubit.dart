import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/clients%20repo/client_repo_imp.dart';
import 'package:almonazim/data/model/client%20models/client_input_model.dart';
import 'package:almonazim/data/model/client%20models/get_client_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'get_clients_balance_state.dart';

class GetClientsBalanceCubit extends SafeCubit<GetClientsBalanceState> {
  GetClientsBalanceCubit(this.clientRepo) : super(GetClientsBalanceInitial());
  ClientRepoImpl clientRepo;
  ScrollController controller = ScrollController();
  List<GetClientModel> allClients = [];
  ClientInputModel clientInputModel =
      ClientInputModel(clientsType: ClientType.customer.name, requestNumber: 0);

  Future<void> getClientsBalance() async {
    addingGridListener();
    emit(GetClientsBalanceLoading());
    var result = await clientRepo.getClientsBalance(clientInputModel);
    result.fold((failure) {
      emit(GetClientsBalanceFailure(failure.errMessage));
    }, (clientsLocal) {
      allClients.addAll(clientsLocal);
      emit(GetClientsBalanceSuccess(clients: allClients));
    });
  }

  void refresh() async {
    clientInputModel.requestNumber = 0;
    allClients.clear();
    getClientsBalance();
  }

  void addingGridListener() async {
    removingGridListener();
    await Future.delayed(const Duration(seconds: 1));
    controller.addListener(onGridScroll);
  }

  void removingGridListener() {
    // ignore: invalid_use_of_protected_member
    if (controller.hasListeners) {
      controller.removeListener(onGridScroll);
    } else {}
  }

  void disposeGridControl() {
    controller.dispose();
  }

  void onGridScroll() {
    if (controller.position.maxScrollExtent == controller.offset) {
      clientInputModel.requestNumber = clientInputModel.requestNumber! + 1;
      getClientsBalance();
    }
  }

  void setCategoryDataCompleted() {
    removingGridListener();
  }

  @override
  Future<void> close() {
    disposeGridControl();
    return super.close();
  }
}
