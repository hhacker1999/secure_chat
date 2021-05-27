part of 'chat_view_model.dart';

abstract class ChatViewState extends Equatable {
  const ChatViewState();
  @override
  List<Object?> get props => [];
}

class ChatViewStateLoading extends ChatViewState {}

class ChatViewStateLoaded extends ChatViewState {
  final List<ChatModel> model;
  const ChatViewStateLoaded({
    required this.model,
  });
}


class ChatViewLoadedwithNoData extends ChatViewState{}