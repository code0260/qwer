// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_ai_cubit.dart';

abstract class ChatAIState extends Equatable {
  const ChatAIState();

  @override
  List<Object> get props => [];
}

class ChatAIInitial extends ChatAIState {}

class ChatAILoading extends ChatAIState {}

class ChatAIFailure extends ChatAIState {
  final String errorMessage;

  const ChatAIFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class ChatAISuccess extends ChatAIState {
  final List<ChatAIModel> messages;
  const ChatAISuccess({
    required this.messages,
  });
}

final class ImageSuccess extends ChatAIState {
  final String path;

  @override
  // TODO: implement props
  List<Object> get props => [path];
  const ImageSuccess({required this.path});
}

final class ImageDelete extends ChatAIState {
  final String path;

  @override
  // TODO: implement props
  List<Object> get props => [path];
  const ImageDelete({required this.path});
}

final class ImageFailure extends ChatAIState {}
