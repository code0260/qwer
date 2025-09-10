import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/ai%20models/chat_ai_input_model.dart';
import 'package:dartz/dartz.dart';

abstract class ChatAIRepo {
  // Future<Either<Failure, ChatAIModel>> chatGemini(
  //     ChatAiInputModel chatAiInputModel, ChatSession chatSession);
  Future<Either<Failure, void>> chatAI(ChatAiInputModel chatAiInputModel);
}
