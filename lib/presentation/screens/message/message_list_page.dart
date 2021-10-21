import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show Message;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:deucepte_open/logic/cubits/message/message_detail_cubit.dart';
import 'package:deucepte_open/logic/cubits/message/message_list_cubit.dart';
import 'package:deucepte_open/presentation/screens/message/message_detail_page.dart';
import 'package:deucepte_open/presentation/widgets/connection_error.dart';
import 'package:deucepte_open/presentation/widgets/shimmer_loading.dart';

class MessageListPage extends StatelessWidget {
  const MessageListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesajlar'),
      ),
      body: BlocBuilder<MessageListCubit, MessageListState>(
        builder: (BuildContext context, MessageListState state) {
          switch (state.status) {
            case MessageListStatus.initial:
              return Container();
            case MessageListStatus.loading:
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: ShimmerLoading(
                  count: 6,
                ),
              );
            case MessageListStatus.success:
              return _MessageListLoaded(
                messages: state.messages,
              );
            case MessageListStatus.failure:
              return ConnectionError(
                fetch: () => context.read<MessageListCubit>().getMessageList(),
              );
          }
        },
      ),
    );
  }
}

class _MessageListLoaded extends StatelessWidget {
  const _MessageListLoaded({Key? key, required this.messages})
      : super(key: key);

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          await context.read<MessageListCubit>().getMessageList(refresh: true),
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          final message = messages[index];
          return ListTile(
            leading: const Icon(Icons.mail),
            title: Text(message.title),
            subtitle: Text(message.sender),
            trailing: Text(message.date),
            onTap: () async {
              final overlay = context.loaderOverlay;
              overlay.show();
              await context
                  .read<MessageDetailCubit>()
                  .getMessageDetail(message);
              overlay.hide();
              Navigator.of(context).push<MaterialPageRoute>(
                MaterialPageRoute(
                  builder: (BuildContext context) => const MessageDetailPage(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
