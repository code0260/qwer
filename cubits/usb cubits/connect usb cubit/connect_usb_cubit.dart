import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/services/print_service.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:equatable/equatable.dart';

part 'connect_usb_state.dart';

class ConnectUSBCubit extends SafeCubit<ConnectUSBState> {
  ConnectUSBCubit() : super(ConnectUSBInitial());
  Future<void> connectUSBDevice(String deviceName) async {
    try {
      emit(ConnectUSBLoading());
      await getIt.get<PrinterService>().connectUSBPrinter(deviceName);
      emit(const ConnectUSBSuccess());
    } on Exception catch (e) {
      emit(ConnectUSBFailure(errorMessage: e.toString()));
    }
  }
}
