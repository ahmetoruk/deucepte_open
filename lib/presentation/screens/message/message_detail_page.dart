import 'package:deucepte_open/presentation/widgets/title_capital_avatar.dart';
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
                padding: const EdgeInsets.all(8.0),
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleCapitalAvatar(
                        letter: state.message.sender.characters.first,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.message.sender,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  state.message.date,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            Text(
                              state.message.title,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            SelectableText(
                              state.message.content!,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
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
