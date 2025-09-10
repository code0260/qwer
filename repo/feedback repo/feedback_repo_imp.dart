import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/feedback%20repo/feedback_repo.dart';
import 'package:almonazim/data/model/feedback%20models/add_feedback_model.dart';
import 'package:dartz/dartz.dart';

class FeedbackRepoImpl implements FeedbackRepo {
  final ApiService apiService;
  FeedbackRepoImpl(this.apiService);

  // @override
  // Future<Either<Failure, List<FeedbackModel>>> getFeedback() async {
  //   final result = await apiService.get(url: AppLinks.getFeedbackLink);

  //   return result.fold(
  //     (failure) => left(failure),
  //     (response) async {
  //       List<int> partnerIds = [];
  //       List<FeedbackModel> feedbackLocale = [];
  //       for (final partner in response["data"]) {
  //         partnerIds.add(partner['feedback_id']);
  //         await StoreFeedback.updateFeedbackData(partner);
  //         feedbackLocale.add(FeedbackModel.fromJson(partner));
  //       }
  //       await StoreFeedback.deleteFeedbackViaIdList(partnerIds);

  //       return right(feedbackLocale);
  //     },
  //   );
  // }
  @override
  Future<Either<Failure, void>> addFeedback(
      AddFeedbackModel addFeedbackModel) async {
    final result = await apiService.uploadFile(
        url: AppLinks.addFeedbackLink,
        filePath: addFeedbackModel.imagePath!,
        requestName: 'feedback_image',
        data: {'data': await addFeedbackModel.toMap()});

    return result.fold(
      (failure) => left(failure),
      (response) async {
        return right(null);
      },
    );
  }
}
