import 'package:deucepte_open/presentation/widgets/message_list_tile.dart';
import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show Message;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:deucepte_open/logic/cubits/message/message_detail_cubit.dart';
import 'package:deucepte_open/logic/cubits/message/message_list_cubit.dart';
import 'package:deucepte_open/presentation/screens/message/message_detail_page.dart';
import 'package:deucepte_open/presentation/screens/message/message_list_page.dart';
import 'package:deucepte_open/presentation/widgets/custom_card.dart';
import 'package:deucepte_open/presentation/widgets/shimmer_loading.dart';

class MessagesCard extends StatelessWidget {
  const MessagesCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Mesajlar',
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => context.read<MessageListCubit>().getMessageList(),
        )
      ],
      content: BlocBuilder<MessageListCubit, MessageListState>(
        builder: (BuildContext context, MessageListState state) {
          switch (state.status) {
            case MessageListStatus.initial:
              return Container();
            case MessageListStatus.loading:
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: ShimmerLoading(
                  count: 3,
                ),
              );
            case MessageListStatus.success:
              if (state.messages.isNotEmpty) {
                return _MessageListLoaded(
                  messages: state.messages,
                );
              }
              return const ListTile(
                title: Text('Mesaj bulunamadı!'),
              );
            case MessageListStatus.failure:
              return const ListTile(
                title: Text('Hata mesajlar yüklenemedi!'),
              );
          }
        },
      ),
    );
  }
}

class _MessageListLoaded extends StatelessWidget {
  const _MessageListLoaded({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    final firstThreeMessages = messages.getRange(0, 3);
    return Column(
      children: <Widget>[
        ...firstThreeMessages.map<Widget>(
          (Message message) => MessageListTile(
            message: message,
            onTap: () => _onTapMessage(context, message),
          ),
        ),
        const Divider(
          height: 0,
        ),
        ListTile(
          title: const Text(
            'Tüm mesajlar',
          ),
          trailing: const Icon(Icons.navigate_next),
          onTap: () => Navigator.of(context).push<MaterialPageRoute>(
            MaterialPageRoute(
              builder: (BuildContext context) => const MessageListPage(),
            ),
          ),
        )
      ],
    );
  }

  void _onTapMessage(BuildContext context, Message message) async {
    final overlay = context.loaderOverlay;
    overlay.show();
    await context.read<MessageDetailCubit>().getMessageDetail(message);
    overlay.hide();
    Navigator.of(context).push<MaterialPageRoute>(
      MaterialPageRoute(
        builder: (BuildContext context) => const MessageDetailPage(),
      ),
    );
  }
}
