import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/clients%20repo/client_repo.dart';
import 'package:almonazim/data/model/client%20models/client_input_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_client_state.dart';

class EditClientCubit extends SafeCubit<EditClientState> {
  EditClientCubit(this.clientRepo) : super(EditClientInitial());
  ClientRepo clientRepo;
  ClientInputModel clientInputModel = ClientInputModel();
  Future<void> editClient() async {
    emit(EditClientLoading());
    var result = await clientRepo.editClient(clientInputModel);
    result.fold((failure) {
      emit(EditClientFailure(failure.errMessage));
    }, (_) {
      emit(EditClientSuccess());
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
