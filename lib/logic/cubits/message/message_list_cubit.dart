import 'package:bloc/bloc.dart';
import 'package:deu_api/deu_api.dart' show Message;
import 'package:equatable/equatable.dart';

import 'package:deucepte_open/data/repositories/message_repository.dart';

enum MessageListStatus { initial, loading, success, failure }

class MessageListState extends Equatable {
  const MessageListState(
      {this.status = MessageListStatus.initial,
      this.messages = const <Message>[]});

  final MessageListStatus status;
  final List<Message> messages;

  MessageListState copyWith({
    MessageListStatus? status,
    List<Message>? messages,
  }) =>
      MessageListState(
        status: status ?? this.status,
        messages: messages ?? this.messages,
      );

  @override
  List<Object?> get props => [status, messages];
}

class MessageListCubit extends Cubit<MessageListState> {
  MessageListCubit(this.messageRepository) : super(const MessageListState());

  final MessageRepository messageRepository;

  Future getMessageList({
    bool refresh = false,
  }) async {
    if (!refresh) {
      emit(state.copyWith(status: MessageListStatus.loading));
    }
    try {
      final messages = await messageRepository.getMessages();
      emit(state.copyWith(
          status: MessageListStatus.success, messages: messages));
    } catch (e) {
      emit(state.copyWith(status: MessageListStatus.failure));
    }
  }
}
