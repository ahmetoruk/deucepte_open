import 'package:bloc/bloc.dart';
import 'package:deu_api/deu_api.dart' show Message;
import 'package:equatable/equatable.dart';

import 'package:deucepte_open/data/repositories/message_repository.dart';

enum MessageDetailStatus { initial, loading, success, failure }

class MessageDetailState extends Equatable {
  MessageDetailState(
      {this.status = MessageDetailStatus.initial, Message? message})
      : message = message ?? Message.empty;

  final MessageDetailStatus status;
  final Message message;

  MessageDetailState copyWith({
    MessageDetailStatus? status,
    Message? message,
  }) {
    return MessageDetailState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}

class MessageDetailCubit extends Cubit<MessageDetailState> {
  MessageDetailCubit(this.messageRepository)
      : super(MessageDetailState(status: MessageDetailStatus.initial));

  final MessageRepository messageRepository;

  Future getMessageDetail(Message message) async {
    emit(state.copyWith(status: MessageDetailStatus.loading));
    try {
      final fetchedMessage = await messageRepository.getMessageDetail(message);
      emit(state.copyWith(
          status: MessageDetailStatus.success, message: fetchedMessage));
    } catch (e) {
      emit(state.copyWith(
          status: MessageDetailStatus.failure, message: message));
    }
  }
}
