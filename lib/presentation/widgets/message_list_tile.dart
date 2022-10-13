import 'package:deu_api/deu_api.dart';
import 'package:deucepte_open/presentation/widgets/title_capital_avatar.dart';
import 'package:flutter/material.dart';

class MessageListTile extends StatelessWidget {
  const MessageListTile({required this.message, required this.onTap, Key? key})
      : super(key: key);

  final Message message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TitleCapitalAvatar(
        letter: message.sender.characters.first,
      ),
      title: Text(message.sender),
      subtitle: Text(message.title),
      trailing: Text(message.date),
      onTap: onTap,
    );
  }
}
