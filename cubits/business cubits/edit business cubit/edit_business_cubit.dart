import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/core/helper/image_generator.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/business%20repo/business_repo_imp.dart';
import 'package:almonazim/data/model/business%20models/add_business_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'edit_business_state.dart';

class EditBusinessCubit extends SafeCubit<EditBusinessState> {
  EditBusinessCubit(this.businessRepo) : super(EditBusinessInitial());
  BusinessRepoImpl businessRepo;
  AddBusinessModel editBusinessModel = AddBusinessModel();
  String? imageFile;
  Future<void> editBusiness() async {
    emit(EditBusinessLoading());
    var result = await businessRepo.editBusiness(editBusinessModel, imageFile);
    result.fold((failure) {
      emit(EditBusinessFailure(errorMessage: failure.errMessage));
    }, (_) async {
      if (imageFile != null) {
        await ImageGenerator.saveImage(
            imageBytes: File(imageFile!).readAsBytesSync(),
            name: StoreUserModel.instance.businessImage!);
      }
      emit(const EditBusinessSuccess());
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
