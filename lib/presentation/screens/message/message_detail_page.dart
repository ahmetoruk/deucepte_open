import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/logic/cubits/message/message_detail_cubit.dart';
import 'package:deucepte_open/presentation/widgets/connection_error.dart';
import 'package:deucepte_open/presentation/widgets/shimmer_loading.dart';

class MessageDetailPage extends StatelessWidget {
  const MessageDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesaj Detayı'),
      ),
      body: BlocBuilder<MessageDetailCubit, MessageDetailState>(
        builder: (BuildContext context, MessageDetailState state) {
          switch (state.status) {
            case MessageDetailStatus.initial:
              return Container();
            case MessageDetailStatus.loading:
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: ShimmerLoading(
                  count: 6,
                ),
              );
            case MessageDetailStatus.success:
              return ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.mail),
                    title: Text(state.message.title),
                    subtitle: Text(state.message.sender),
                    trailing: Text(state.message.date),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(state.message.content ?? ''),
                  ),
                ],
              );
            case MessageDetailStatus.failure:
              return ConnectionError(
                fetch: () => context
                    .read<MessageDetailCubit>()
                    .getMessageDetail(state.message),
              );
          }
        },
      ),
    );
  }
}
