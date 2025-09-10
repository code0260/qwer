import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/asset%20functions/translate%20asset/translate_asset_state.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/assets%20repo/asset_repo_imp.dart';
import 'package:almonazim/data/model/asset%20models/asset_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_asset_state.dart';

class AddAssetCubit extends SafeCubit<AddAssetState> {
  AddAssetCubit(this.assetRepo)
      : super(const AddAssetInitial(hasDepreciation: true));
  AssetRepoImpl assetRepo;

  AssetInputModel addAssetModel = AssetInputModel(
      assetsPurchaseDate: DateTime.now().toString(),
      hasDepreciation: true,
      assetsStatus: translateToEnAssetStatusEnum(AssetStatus.active));

  Future<void> addAsset() async {
    prepareBaseAmount();
    emit(AddAssetLoading());
    var result = await assetRepo.addAsset(addAssetModel);
    result.fold((failure) {
      emit(AddAssetFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(AddAssetSuccess());
    });
  }

  void prepareBaseAmount() {
    if (addAssetModel.assetsCurrencyId !=
        currencies
            .firstWhere(
              (element) => element.businessCurrencyIsBase == 1,
            )
            .businessCurrencyId) {
      addAssetModel.assetsCostInBase = convertAmountToBase(
          addAssetModel.assetsCost!, addAssetModel.assetsCurrencyId!);
    } else {
      addAssetModel.assetsCostInBase = null;
    }
  }

  void reverseHasDepreciation(bool value) {
    addAssetModel.hasDepreciation = value;
    emit(AddAssetInitial(hasDepreciation: value));
  }

  String? get validateDataMessage {
    if (addAssetModel.assetsName == null || addAssetModel.assetsName!.isEmpty) {
      return "الرجاء إدخال اسم الأصل";
    } else if (addAssetModel.assetsCategory == null ||
        addAssetModel.assetsCategory!.isEmpty) {
      return "الرجاء اختيار فئة الأصل";
    } else if (addAssetModel.assetsPurchaseDate == null ||
        addAssetModel.assetsPurchaseDate!.isEmpty) {
      return "الرجاء تحديد تاريخ الشراء";
    } else if (addAssetModel.assetsCost == null ||
        addAssetModel.assetsCost == 0) {
      return "الرجاء إدخال تكلفة الأصل";
    } else if (addAssetModel.assetsStatus == null ||
        addAssetModel.assetsStatus!.isEmpty) {
      return "الرجاء تحديد حالة الأصل";
    } else if (addAssetModel.assetsCurrencyId == null) {
      return "الرجاء اختيار العملة";
    } else if (addAssetModel.hasDepreciation == true) {
      if (addAssetModel.depreciationMethod == null ||
          addAssetModel.depreciationMethod!.isEmpty) {
        return "الرجاء اختيار طريقة الإهلاك";
      } else if (addAssetModel.depreciationAssetUsefulLife == null) {
        return "الرجاء تحديد العمر الافتراضي للأصل";
      } else if (addAssetModel.depreciationRate == null) {
        return "الرجاء تحديد معدل الاستهلاك للأصل";
      }
    } else {
      return null;
    }
    return null;
  }
}
