part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

// fetch list of conversations
class FetchChatListEvent extends ChatEvent {
  const FetchChatListEvent();
}

// new conversation added to list
class ReceivedChatListEvent extends ChatEvent {
  final List<ChatConversation> chatList;

  const ReceivedChatListEvent(this.chatList);

  @override
  List<Object> get props => [chatList];
}

// fetch individual conversation
class FetchIndividualChatEvent extends ChatEvent {
  final String chatId;

  const FetchIndividualChatEvent(this.chatId);

  @override
  List<Object> get props => [chatId];
}

// new message added to conversation
class ReceivedIndividualChatEvent extends ChatEvent {
  final List<Message> messages;
  final String chatId;

  const ReceivedIndividualChatEvent(this.messages, this.chatId);
}

// send a new message
class SendMessageEvent extends ChatEvent {
  final String message;

  const SendMessageEvent(this.message);
}
