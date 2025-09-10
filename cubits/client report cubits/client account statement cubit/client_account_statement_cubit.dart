import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/client%20report%20repos/client%20report%20repo/client_report_repo.dart';
import 'package:almonazim/data/model/client%20models/client_input_model.dart';
import 'package:almonazim/data/model/report%20models/client%20report%20models/client_account_statement_model.dart';
import 'package:equatable/equatable.dart';

part 'client_account_statement_state.dart';

class ClientAccountStatementCubit
    extends SafeCubit<ClientAccountStatementState> {
  ClientAccountStatementCubit(this.clientRepo)
      : super(ClientAccountStatementInitial());
  ClientReportRepo clientRepo;
  ClientInputModel clientInputModel =
      ClientInputModel(clientsCreatedAt: DateTime.now().toString());
  Future<void> getClientAccountStatement() async {
    emit(ClientAccountStatementLoading());
    var result = await clientRepo.getClientAccountStatements(clientInputModel);
    result.fold((failure) {
      emit(ClientAccountStatementFailure(failure.errMessage));
    }, (model) {
      emit(ClientAccountStatementSuccess(statementModel: model));
    });
  }

  String? get validateClientDataMessage {
    if (clientInputModel.clientsId == null) {
      return "الرجاء اختيار العميل";
    } else if (clientInputModel.clientsType == null ||
        clientInputModel.clientsType!.isEmpty) {
      return "الرجاء اختيار نوع العميل";
    } else {
      return null;
    }
  }
}
