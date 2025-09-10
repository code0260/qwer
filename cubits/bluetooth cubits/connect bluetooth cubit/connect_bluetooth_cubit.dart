import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/services/print_service.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:equatable/equatable.dart';

part 'connect_bluetooth_state.dart';

class ConnectBluetoothCubit extends SafeCubit<ConnectBluetoothState> {
  ConnectBluetoothCubit() : super(ConnectBluetoothInitial());
  Future<void> connectBluetoothDevice(String deviceName) async {
    try {
      emit(ConnectBluetoothLoading());
      await getIt.get<PrinterService>().connectBluetoothPrinter(deviceName);
      emit(const ConnectBluetoothSuccess());
    } on Exception catch (e) {
      emit(ConnectBluetoothFailure(errorMessage: e.toString()));
    }
  }
}
