part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class InitialChatState extends ChatState {}

class FetchedMessagesState extends ChatState {
  final List<Message> messages;
  const FetchedMessagesState(this.messages);

  @override
  String toString() => 'FetchedMessagesState';
}

class ErrorState extends ChatState {
  final ChatStorageException exception;
  const ErrorState(this.exception);

  @override
  String toString() => 'ErrorState';
}
