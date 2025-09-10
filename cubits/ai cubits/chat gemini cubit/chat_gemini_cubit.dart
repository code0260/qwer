// import 'dart:io';

// import 'package:almonazim/core/helper/functions/other%20functions/pick_file.dart';
// import 'package:almonazim/cubits/safe_cubit.dart';
// import 'package:almonazim/data/data%20source/repo/ai%20repos/chat%20ai%20repo/chat_ai_repo_imp.dart';
// import 'package:almonazim/data/model/ai%20models/chat_ai_input_model.dart';
// import 'package:almonazim/data/model/ai%20models/chat_ai_model.dart';
// import 'package:equatable/equatable.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

// part 'chat_gemini_state.dart';

// class ChatGeminiCubit extends SafeCubit<ChatGeminiState> {
//   ChatGeminiCubit(this.chatAIRepoIml) : super(ChatGeminiInitial());
//   ChatAIRepoImpl chatAIRepoIml;
//   late ChatSession chat;
//   final List<ChatAIModel> messages = [
//     ChatAIModel(role: 'AI', content: "كيف يمكنني مساعدك؟")
//   ];
//   GenerativeModel model = GenerativeModel(
//     model: 'gemini-2.0-flash',
//     apiKey: 'AIzaSyC2oPyjoitx0c1my3aslSC6RM41OLll_WQ',
//   );
//   ChatAiInputModel chatAiInputModel =
//       ChatAiInputModel(files: [], images: [], prompt: '');

//   Future<void> sendMessage() async {
//     messages.add(ChatAIModel(role: 'user', content: chatAiInputModel.prompt));
//     emit(ChatGeminiLoading());
//     var result = await chatAIRepoIml.chatGemini(chatAiInputModel, chat);
//     result.fold((failure) {
//       emit(ChatGeminiFailure(errorMessage: failure.errMessage));
//     }, (ChatAIModel chatAiModel) {
//       messages.add(chatAiModel);
//       emit(ChatGeminiSuccess(messages: messages));
//     });
//   }

//   void init() {
//     chat = model.startChat();
//   }

//   Future<void> pickImage() async {
//     File? result = await pickFile(fileType: FileType.image);
//     if (result != null) {
//       chatAiInputModel.images.add(result);
//       emit(ImageSuccess());
//     } else {
//       emit(ImageFailure());
//     }
//   }

//   Future<void> pickFiles() async {
//     File? result = await pickFile();
//     if (result != null) {
//       chatAiInputModel.files.add(result);
//       emit(ImageSuccess());
//     } else {
//       emit(ImageFailure());
//     }
//   }
// }
