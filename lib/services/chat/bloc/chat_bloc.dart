import 'package:bloc/bloc.dart';
import 'package:building/models/chat_convo.dart';
import 'package:building/models/chat_message.dart';
import 'package:building/services/chat/chat_exceptions.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(InitialChatState()) {
    on<FetchChatListEvent>(_onFetchChatList);
    on<FetchIndividualChatEvent>(_onFetchIndividualChat);
    on<SendMessageEvent>(_onSendMessage);
  }

  void _onFetchChatList(FetchChatListEvent event, Emitter<ChatState> emit) {}

  void _onFetchIndividualChat(
      FetchIndividualChatEvent event, Emitter<ChatState> emit) {}

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) {}
}
