import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/ai%20repos/chat%20ai%20repo/chat_ai_repo.dart';
import 'package:almonazim/data/model/ai%20models/chat_ai_input_model.dart';
import 'package:almonazim/data/model/ai%20models/chat_ai_model.dart';
import 'package:dartz/dartz.dart';

class ChatAIRepoImpl implements ChatAIRepo {
  final ApiService apiService;
  ChatAIRepoImpl(this.apiService);

  // @override
  // Future<Either<Failure, ChatAIModel>> chatGemini(
  //     ChatAiInputModel chatAiInputModel, ChatSession chatSession) async {
  //   try {
  //     final List<Part> parts = [];
  //     // Add text
  //     parts.add(TextPart(chatAiInputModel.prompt));

  //     // Add image as bytes
  //     if (chatAiInputModel.images.isNotEmpty) {
  //       for (final image in chatAiInputModel.images) {
  //         final bytes = await File(image).readAsBytes();
  //         parts.add(DataPart('image/png', bytes));
  //       }
  //     }

  //     // Add image as bytes
  //     if (chatAiInputModel.files.isNotEmpty) {
  //       for (final file in chatAiInputModel.files) {
  //         final bytes = await File(file).readAsBytes();
  //         parts.add(DataPart('application/pdf', bytes));
  //       }
  //     }

  //     final response = await chatSession.sendMessage(Content.multi(parts));

  //     return right(ChatAIModel(role: 'AI', content: response.text!));
  //   } catch (e) {
  //     return left(ServerFailure(e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, ChatAIModel>> chatAI(
      ChatAiInputModel chatAiInputModel) async {
    // print(addBusinessModel.toMap());

    final Either<Failure, dynamic> result;
    List<String> allFiles = [];
    allFiles.addAll(chatAiInputModel.files);
    allFiles.addAll(chatAiInputModel.images);

    List<String> requestNames = [];
    requestNames.addAll(List.generate(
        chatAiInputModel.images.length, (index) => "image${index + 1}"));

    requestNames.addAll(List.generate(
        chatAiInputModel.files.length, (index) => "file${index + 1}"));

    result = await apiService.uploadMultipleFiles(
        filesPath: allFiles,
        requestNames: requestNames,
        url: AppLinks.chatAiLink,
        data: {"prompt": chatAiInputModel.prompt});
    return result.fold((failure) {
      return left(failure);
    }, (response) {
      return right(ChatAIModel(role: 'AI', content: response['data']));
    });
    // return right(null);
  }
}
