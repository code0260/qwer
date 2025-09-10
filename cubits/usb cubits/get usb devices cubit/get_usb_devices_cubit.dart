import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/services/print_service.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:equatable/equatable.dart';

part 'get_usb_devices_state.dart';

class GetUSBDevicesCubit extends SafeCubit<GetUSBDevicesState> {
  GetUSBDevicesCubit() : super(GetUSBDevicesInitial());
  Future<void> getUSBDevices() async {
    try {
      emit(GetUSBDevicesLoading());
      List<String> devices = await getIt.get<PrinterService>().getUSBPrinter();
      emit(GetUSBDevicesSuccess(devices: devices));
    } on Exception catch (e) {
      emit(GetUSBDevicesFailure(errorMessage: e.toString()));
    }
  }
}
