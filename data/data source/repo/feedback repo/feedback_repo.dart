import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/feedback%20models/add_feedback_model.dart';
import 'package:dartz/dartz.dart';

abstract class FeedbackRepo {
  // Future<Either<Failure, List<FeedbackModel>>> getFeedback();
  Future<Either<Failure, void>> addFeedback(AddFeedbackModel addFeedbackModel);
}
