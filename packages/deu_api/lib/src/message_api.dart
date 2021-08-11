import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html;

import 'package:deu_api/src/api.dart';
import 'package:deu_api/src/helpers/encoding_helper.dart';
import 'package:deu_api/src/models/message.dart';

class MessageApi {
  MessageApi(this.client);

  final DeuClient client;

  Future<List<Message>> fetchMessages() async {
    final fetchedMessages = <Message>[];
    for (final catId in [1, 3]) {
      final response = await client.get(
        'https://debis.deu.edu.tr/DEUWeb/mesaj/index.php?&cat=$catId',
        options: Options(responseType: ResponseType.bytes),
      );
      final requestData = customEncode(response);
      final trElements = html
          .parse(requestData)
          .querySelector('#mesajformu')!
          .querySelectorAll('tr');
      if (trElements.length > 2) {
        trElements.removeAt(0);
        for (final trElement in trElements) {
          fetchedMessages.add(Message(
              sender: trElement.children[1].text,
              title: trElement.children[2].text,
              date: trElement.children[3].text,
              url: 'https://debis.deu.edu.tr/DEUWeb/mesaj/' +
                  trElement.children[2].firstChild!.attributes['href']!));
        }
      }
      await Future.delayed(const Duration(seconds: 1));
    }
    return fetchedMessages;
  }

  Future<Message> fetchMessageDetail(Message message) async {
    final response = await client.get(
      message.url,
      options: Options(responseType: ResponseType.bytes),
    );
    final requestData = customEncode(response);
    final messageText = html
        .parse(requestData)
        .querySelectorAll('table')[7]
        .children[0]
        .children[1]
        .children[1]
        .innerHtml;
    return message.copyWith(content: messageText);
  }
}
