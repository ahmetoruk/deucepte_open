import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/logic/cubits/lecture/lecture_notification_cubit.dart';
import 'package:deucepte_open/presentation/screens/lecture/lecture_notification_list_page.dart';
import 'package:deucepte_open/presentation/widgets/custom_card.dart';

class NotificationsCard extends StatelessWidget {
  const NotificationsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Bildirimler',
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () =>
              context.read<LectureNotificationListCubit>().getNotifications(),
        )
      ],
      content: BlocBuilder<LectureNotificationListCubit,
          LectureNotificationListState>(
        builder: (BuildContext context, LectureNotificationListState state) {
          switch (state.status) {
            case LectureNotificationStatus.initial:
              return Container();
            case LectureNotificationStatus.success:
              final count = state.lectureNotifications.length;
              return ListTile(
                title: Text('Aktif bildirimler: $count'),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => Navigator.of(context).push<dynamic>(
                  MaterialPageRoute<Widget>(
                    builder: (BuildContext context) =>
                        const LectureNotificationListPage(),
                  ),
                ),
              );
            case LectureNotificationStatus.failure:
              return Container();
          }
        },
      ),
    );
  }
}
