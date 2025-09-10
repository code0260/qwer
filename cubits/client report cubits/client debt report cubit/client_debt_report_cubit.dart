import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/client%20report%20functions/save_client_debt_report_and_open.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/client%20report%20repos/client%20report%20repo/client_report_repo.dart';
import 'package:almonazim/data/model/client%20models/client_debt_report_input_model.dart';
import 'package:equatable/equatable.dart';

part 'client_debt_report_state.dart';

class ClientDebtReportCubit extends SafeCubit<ClientDebtReportState> {
  ClientDebtReportCubit(this.clientReportRepo)
      : super(ClientDebtReportInitial());
  ClientReportRepo clientReportRepo;
  ClientDebtReportInputModel clientDebtReportInputModel =
      ClientDebtReportInputModel(fileType: ReportFileType.pdf, types: []);

  Future<void> createClientDebtReport() async {
    try {
      emit(ClientDebtReportLoading());
      var result = await clientReportRepo
          .getClientDebtReport(clientDebtReportInputModel);
      result.fold((failure) {
        emit(ClientDebtReportFailure(errorMessage: failure.errMessage));
      }, (bytes) async {
        await saveClientDebtReportAndOpen(bytes, clientDebtReportInputModel);
        emit(ClientDebtReportSuccess());
      });
    } on Exception catch (e) {
      emit(ClientDebtReportFailure(errorMessage: e.toString()));
    }
  }
}
