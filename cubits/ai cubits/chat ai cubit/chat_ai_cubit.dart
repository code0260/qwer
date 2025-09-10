import 'dart:io';

import 'package:almonazim/core/helper/functions/other%20functions/convert_excel_to_csv.dart';
import 'package:almonazim/core/helper/functions/other%20functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/ai%20repos/chat%20ai%20repo/chat_ai_repo_imp.dart';
import 'package:almonazim/data/model/ai%20models/chat_ai_input_model.dart';
import 'package:almonazim/data/model/ai%20models/chat_ai_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'chat_ai_state.dart';

class ChatAICubit extends SafeCubit<ChatAIState> {
  ChatAICubit(this.chatAIRepoIml) : super(ChatAIInitial());
  ChatAIRepoImpl chatAIRepoIml;
  final List<ChatAIModel> messages = [
    ChatAIModel(
        role: 'AI',
        content: "السلام عليكم ورحمة الله وبركاته. كيف يمكنني مساعدتك اليوم؟"),
    // ChatAIModel(role: 'user', content: "كيف يمكنني مساعدك؟")
  ];
  ChatAiInputModel chatAiInputModel =
      ChatAiInputModel(files: [], images: [], prompt: '');

  Future<void> sendMessage() async {
    messages.add(ChatAIModel(role: 'user', content: chatAiInputModel.prompt));
    emit(ChatAILoading());
    chatAiInputModel.prompt = """
    your now chatting with a user and these are the messages sent till now, please answer list message!
    ${messages.map((e) => e.toMap())}
    """;
    var result = await chatAIRepoIml.chatAI(chatAiInputModel);
    result.fold((failure) {
      messages.removeLast();
      emit(ChatAIFailure(errorMessage: failure.errMessage));
    }, (ChatAIModel chatAiModel) {
      messages.add(chatAiModel);
      emit(ChatAISuccess(messages: messages));
    });
  }

  Future<void> pickImage() async {
    File? result = await pickFile(fileType: FileType.image);
    if (result != null) {
      if (!chatAiInputModel.images.contains(result.path)) {
        chatAiInputModel.images.add(result.path.replaceAll(r"\", '/'));
      }
      emit(ImageSuccess(path: result.path.replaceAll(r"\", '/')));
    } else {
      emit(ImageFailure());
    }
  }

  Future<void> pickFiles() async {
    File? result = await pickFile(allowedExtensions: [
      'xlsx',
      'csv',
      'txt',
      'docx',
      "jpg",
      "png",
      "gif",
      "mp3",
      "pdf",
      "svg",
      "jpeg"
    ]);
    if (result != null) {
      if (!chatAiInputModel.files.contains(result.path)) {
        String path = result.path.replaceAll(r'\', '/');
        if (result.path.contains('.xlsx')) {
          path = await convertXlsxToCsv(path);
        }
        chatAiInputModel.files.add(path);
      }
      emit(ImageSuccess(path: result.path));
    } else {
      emit(ImageFailure());
    }
  }

  void addFile(String path) async {
    String filePath = path.replaceAll(r'\', '/');

    if (path.contains('.xlsx')) {
      filePath = await convertXlsxToCsv(path);
    }
    chatAiInputModel.files.add(filePath.replaceAll(r"\", '/'));
    emit(ImageSuccess(path: filePath.replaceAll(r"\", '/')));
  }

  void deleteFile(String path) {
    chatAiInputModel.images.remove(path);
    chatAiInputModel.files.remove(path);
    emit(ImageDelete(path: path));
  }
}
