import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show LectureNotification;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/logic/cubits/lecture/lecture_notification_cubit.dart';
import 'package:deucepte_open/logic/cubits/semester/semester_cubit.dart';
import 'package:deucepte_open/presentation/widgets/connection_error.dart';

class LectureNotificationListPage extends StatelessWidget {
  const LectureNotificationListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirimler'),
      ),
      body: BlocBuilder<LectureNotificationListCubit,
          LectureNotificationListState>(
        builder: (BuildContext context, LectureNotificationListState state) {
          switch (state.status) {
            case LectureNotificationStatus.initial:
              return Container();
            case LectureNotificationStatus.success:
              return _LectureNotificationLoaded(
                  lectureNotificationList: state.lectureNotifications);
            case LectureNotificationStatus.failure:
              return ConnectionError(
                fetch: () => context.read<SemesterListCubit>().getSemesters(),
              );
          }
        },
      ),
    );
  }
}

class _LectureNotificationLoaded extends StatelessWidget {
  const _LectureNotificationLoaded(
      {Key? key, required this.lectureNotificationList})
      : super(key: key);

  final List<LectureNotification> lectureNotificationList;

  @override
  Widget build(BuildContext context) {
    return lectureNotificationList.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_off,
                  size: 100,
                  color: Theme.of(context).disabledColor,
                ),
                Text('Aktif bildirim yok.',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          )
        : ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: lectureNotificationList.length,
            itemBuilder: (BuildContext context, int index) {
              final lectureNotification = lectureNotificationList[index];
              return ListTile(
                title: Text(lectureNotification.lecture.metaData.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => context
                      .read<LectureNotificationListCubit>()
                      .removeNotification(lectureNotification.lecture),
                ),
              );
            },
          );
  }
}
