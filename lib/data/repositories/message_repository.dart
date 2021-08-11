import 'package:deu_api/deu_api.dart' show Message, MessageApi;

abstract class IMessageRepository {
  Future<List<Message>> getMessages();
  Future<Message> getMessageDetail(Message message);
}

class MessageRepository implements IMessageRepository {
  MessageRepository(this.messageApi);

  final MessageApi messageApi;

  @override
  Future<List<Message>> getMessages() async {
    return await messageApi.fetchMessages();
  }

  @override
  Future<Message> getMessageDetail(Message message) async {
    return await messageApi.fetchMessageDetail(message);
  }
}
