import 'package:almonazim/core/helper/functions/account%20functions/get_all_accounts.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/partners%20repo/partner_repo.dart';
import 'package:almonazim/data/model/partner%20models/add_partner_model.dart';
import 'package:almonazim/data/model/partner%20models/partner_input_model.dart';
import 'package:almonazim/data/model/user%20models/user_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_partner_state.dart';

class AddPartnerCubit extends SafeCubit<AddPartnerState> {
  AddPartnerCubit(this.partnersRepo) : super(AddPartnerInitial());

  final PartnerRepo partnersRepo;
  AddPartnerModel addPartnerModel = AddPartnerModel(
      partnerInputModel: PartnerInputModel(), userInputModel: UserInputModel());

  Future<void> addPartner() async {
    emit(AddPartnerLoading());
    final result = await partnersRepo.addPartner(addPartnerModel);
    result.fold((failure) {
      emit(AddPartnerFailure(failure.errMessage));
    }, (_) {
      getAllAccounts();
      emit(const AddPartnerSuccess());
    });
  }

  String? get validatePartnerDataMessage {
    if (addPartnerModel.partnerInputModel.partnersName == null ||
        addPartnerModel.partnerInputModel.partnersName!.isEmpty) {
      return "الرجاء إدخال اسم الشريك";
    } else if (addPartnerModel.partnerInputModel.partnersType == null ||
        addPartnerModel.partnerInputModel.partnersType!.isEmpty) {
      return "الرجاء اختيار نوع الشريك";
    } else if (addPartnerModel.partnerInputModel.partnersOwnershipPercentage ==
            null ||
        addPartnerModel
            .partnerInputModel.partnersOwnershipPercentage!.isEmpty) {
      return "الرجاء إدخال نسبة الحصة";
    } else if (addPartnerModel.isUser == true &&
        addPartnerModel.userInputModel.usersPassword == null) {
      return "الرجاء إدخال كلمة السر";
    } else if (addPartnerModel.isUser == true &&
        addPartnerModel.userInputModel.usersEmail == null) {
      return "الرجاء إدخال البريد الالكتروني";
    } else {
      return null;
    }
  }
}
