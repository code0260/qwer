import 'package:almonazim/cubits/safe_cubit.dart';

class TotalDebtAmountCubit extends SafeCubit<double> {
  TotalDebtAmountCubit() : super(0);

  void editValue(double amount) {
    emit(amount);
  }
}
