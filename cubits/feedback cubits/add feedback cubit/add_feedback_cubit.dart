import 'dart:io';

import 'package:almonazim/core/helper/image_generator.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/feedback%20repo/feedback_repo_imp.dart';
import 'package:almonazim/data/model/feedback%20models/add_feedback_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'add_feedback_state.dart';

class AddFeedbackCubit extends SafeCubit<AddFeedbackState> {
  AddFeedbackCubit(this.businessRepo) : super(AddFeedbackInitial());
  FeedbackRepoImpl businessRepo;
  AddFeedbackModel addFeedbackModel = AddFeedbackModel();
  Future<void> addFeedback() async {
    emit(AddFeedbackLoading());
    var result = await businessRepo.addFeedback(addFeedbackModel);
    result.fold((failure) {
      emit(AddFeedbackFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(const AddFeedbackSuccess());
    });
  }

  Future<void> assignImagePath(Uint8List screenShot) async {
    File image = await ImageGenerator.saveTempImage(
        imageBytes: screenShot, name: 'screenshot.png');
    addFeedbackModel.imagePath = image.path;
  }
}
