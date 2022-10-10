import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show Lecture, LectureNotification;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/logic/cubits/lecture/lecture_detail_cubit.dart';
import 'package:deucepte_open/logic/cubits/lecture/lecture_notification_cubit.dart';
import 'package:deucepte_open/presentation/widgets/connection_error.dart';
import 'package:deucepte_open/presentation/widgets/shimmer_loading.dart';

class LectureDetailPage extends StatelessWidget {
  const LectureDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const _LectureDetailListTitle(),
          actions: const <Widget>[
            _NotificationIcon(),
          ],
        ),
        body: BlocBuilder<LectureDetailCubit, LectureDetailState>(
          builder: (BuildContext context, LectureDetailState state) {
            switch (state.status) {
              case LectureDetailStatus.initial:
                return Container();
              case LectureDetailStatus.loading:
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ShimmerLoading(
                    count: 6,
                  ),
                );
              case LectureDetailStatus.success:
                return _LectureDetailLoaded(
                  lecture: state.lecture,
                );
              case LectureDetailStatus.failure:
                return ConnectionError(
                    fetch: () => context
                        .read<LectureDetailCubit>()
                        .getLectureDetail(state.lecture));
            }
          },
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          child: const TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'Notlar',
              ),
              Tab(
                text: 'Detaylar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LectureDetailLoaded extends StatelessWidget {
  const _LectureDetailLoaded({Key? key, required this.lecture})
      : super(key: key);

  final Lecture lecture;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<LectureDetailCubit>().getLectureDetail(lecture),
      child: TabBarView(
        children: <Widget>[
          Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => context
                      .read<LectureDetailCubit>()
                      .getLectureDetail(lecture, refresh: true),
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: lecture.gradeList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final lectureGrade = lecture.gradeList![index];
                      return ListTile(
                        leading: const Icon(Icons.library_add),
                        title: Text(lectureGrade.name),
                        trailing: Text(lectureGrade.note),
                        subtitle:
                            Text('Sınıf ort: ${lectureGrade.classAverage}'),
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                padding: const EdgeInsets.all(10),
                child: Text(
                  lecture.statusText ?? 'Hata!',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: lecture.detailList!.length,
            itemBuilder: (BuildContext context, int index) {
              final lectureDetail = lecture.detailList![index];
              return ListTile(
                title: Text(lectureDetail.name),
                trailing: Text(lectureDetail.detail),
              );
            },
          )
        ],
      ),
    );
  }
}

class _LectureDetailListTitle extends StatelessWidget {
  const _LectureDetailListTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LectureDetailCubit, LectureDetailState>(
      builder: (BuildContext context, LectureDetailState state) {
        switch (state.status) {
          case LectureDetailStatus.initial:
            return Container();
          case LectureDetailStatus.loading:
            return const Text('Yükleniyor..');
          case LectureDetailStatus.success:
            return Text(state.lecture.metaData.name);
          case LectureDetailStatus.failure:
            return const Text('Bağlantı hatası');
        }
      },
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({
    Key? key,
  }) : super(key: key);

  final disabledIcon = const IconButton(
      icon: Icon(
        Icons.notifications,
      ),
      onPressed: null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LectureDetailCubit, LectureDetailState>(
      builder: (BuildContext context, LectureDetailState lectureDetailState) {
        if (lectureDetailState.status == LectureDetailStatus.success) {
          final lecture = lectureDetailState.lecture;
          return BlocBuilder<LectureNotificationListCubit,
              LectureNotificationListState>(
            builder:
                (BuildContext context, LectureNotificationListState state) {
              if (state.status == LectureNotificationStatus.success) {
                final isNotificationIsActive = state.lectureNotifications
                    .where((LectureNotification notification) =>
                        notification.lecture.metaData.uniqueId ==
                        lecture.metaData.uniqueId)
                    .isNotEmpty;
                return IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: isNotificationIsActive ? Colors.green : null,
                  ),
                  onPressed: () => !isNotificationIsActive
                      ? context
                          .read<LectureNotificationListCubit>()
                          .addNotification(lecture)
                      : context
                          .read<LectureNotificationListCubit>()
                          .removeNotification(lecture),
                );
              }
              return disabledIcon;
            },
          );
        }
        return disabledIcon;
      },
    );
  }
}
