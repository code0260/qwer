import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_clients.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/clients%20repo/client_repo.dart';
import 'package:almonazim/data/model/client%20models/client_input_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'add_client_state.dart';

class AddClientCubit extends SafeCubit<AddClientState> {
  AddClientCubit(this.clientRepo) : super(AddClientInitial());
  ClientRepo clientRepo;
  ClientInputModel clientInputModel =
      ClientInputModel(clientsCreatedAt: DateTime.now().toString());
  Future<void> addClient() async {
    emit(AddClientLoading());
    Either<Failure, void> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      clientInputModel.clientsBusinessId = StoreUserModel.instance.businessId;
      clientInputModel.clientsOnline = 0;
      result =
          await StoreClients.insertClient(clientInputModel.toDatabaseMap());
    } else {
      result = await clientRepo.addClient(clientInputModel);
    }

    result.fold((failure) {
      emit(AddClientFailure(failure.errMessage));
    }, (_) {
      emit(const AddClientSuccess());
    });
  }

  String? get validateClientDataMessage {
    if (clientInputModel.clientsName == null ||
        clientInputModel.clientsName!.isEmpty) {
      return "الرجاء إدخال اسم العميل";
    } else if (clientInputModel.clientsType == null ||
        clientInputModel.clientsType!.isEmpty) {
      return "الرجاء اختيار نوع العميل";
    } else {
      return null;
    }
  }
}
