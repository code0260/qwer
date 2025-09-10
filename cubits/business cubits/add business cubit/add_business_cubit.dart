import 'dart:io';

import 'package:almonazim/core/helper/functions/other%20functions/pick_file.dart';
import 'package:almonazim/core/helper/image_generator.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/business%20repo/business_repo_imp.dart';
import 'package:almonazim/data/model/business%20models/add_business_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'add_business_state.dart';

class AddBusinessCubit extends SafeCubit<AddBusinessState> {
  AddBusinessCubit(this.businessRepo) : super(AddBusinessInitial());
  BusinessRepoImpl businessRepo;
  AddBusinessModel addBusinessModel = AddBusinessModel();
  String? imageFile;
  int? baseCurrencyId;
  Future<void> addBusiness() async {
    emit(AddBusinessLoading());
    var result = await businessRepo.addBusiness(
        addBusinessModel, baseCurrencyId!, imageFile);
    result.fold((failure) {
      emit(AddBusinessFailure(errorMessage: failure.errMessage));
    }, (_) {
      if (imageFile != null) {
        ImageGenerator.saveImage(
            imageBytes: File(imageFile!).readAsBytesSync(),
            name: StoreUserModel.instance.businessImage!);
      }
      emit(const AddBusinessSuccess());
    });
  }

  Future<void> pickImage() async {
    File? result = await pickFile(fileType: FileType.image);
    if (result != null) {
      imageFile = result.path;
      emit(ImageSuccess());
    } else {
      emit(ImageFailure());
    }
  }
}
