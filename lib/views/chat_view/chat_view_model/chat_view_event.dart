part of 'chat_view_model.dart';

abstract class ChatViewEvent extends Equatable {
  const ChatViewEvent();
  @override
  List<Object?> get props => [];
}

class LoadChatEvent extends ChatViewEvent {
  final String other;
  const LoadChatEvent({
    required this.other,
  });
}

class SendMessageEvent extends ChatViewEvent {
  final String other;
  final String message;
  final Timestamp time;
  SendMessageEvent({
    required this.other,
    required this.message,
    required this.time,
  });
}
