import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/rent%20repo/rent_repo.dart';
import 'package:almonazim/data/model/revenues%20models/rent_prepaid_revenue_input_model.dart';
import 'package:almonazim/data/model/revenues%20models/rent_prepaid_revenue_model.dart';
import 'package:equatable/equatable.dart';

part 'get_rent_prepaid_revenues_state.dart';

class GetRevenueRentsCubit extends SafeCubit<GetRevenueRentsState> {
  GetRevenueRentsCubit(this.rentRepo) : super(GetRevenueRentsInitial());
  RentRepo rentRepo;
  RentPrepaidRevenueInputModel rentPrepaidRevenueInputModel =
      RentPrepaidRevenueInputModel(
          rentPrepaidRevenuesStartDate: DateTime.now().toString(),
          rentPrepaidRevenuesEndDate:
              DateTime.now().add(const Duration(days: 30 * 2)).toString());
  Future<void> getRents() async {
    emit(GetRevenueRentsLoading());
    var result = await rentRepo.getRevenueRents(rentPrepaidRevenueInputModel);
    result.fold((failure) {
      emit(GetRevenueRentsFailure(failure.errMessage));
    }, (employees) {
      emit(GetRevenueRentsSuccess(rents: employees));
    });
  }
}
