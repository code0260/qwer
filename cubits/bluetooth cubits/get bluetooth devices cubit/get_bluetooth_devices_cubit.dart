import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/services/print_service.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:equatable/equatable.dart';

part 'get_bluetooth_devices_state.dart';

class GetBluetoothDevicesCubit extends SafeCubit<GetBluetoothDevicesState> {
  GetBluetoothDevicesCubit() : super(GetBluetoothDevicesInitial());
  Future<void> getBluetoothDevices() async {
    try {
      emit(GetBluetoothDevicesLoading());
      List<String> devices =
          await getIt.get<PrinterService>().getBluetoothPrinter();
      emit(GetBluetoothDevicesSuccess(devices: devices));
    } on Exception catch (e) {
      emit(GetBluetoothDevicesFailure(errorMessage: e.toString()));
    }
  }
}
