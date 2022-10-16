import 'package:deucepte_open/presentation/screens/lecture/lecture_list_page.dart';
import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show Lecture, LectureNotification;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/logic/cubits/lecture/lecture_detail_cubit.dart';
import 'package:deucepte_open/logic/cubits/lecture/lecture_notification_cubit.dart';
import 'package:deucepte_open/presentation/widgets/connection_error.dart';
import 'package:deucepte_open/presentation/widgets/shimmer_loading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LectureDetailPage extends HookWidget {
  const LectureDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showDetailsState = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                showDetails: showDetailsState.value,
              );
            case LectureDetailStatus.failure:
              return ConnectionError(
                  fetch: () => context
                      .read<LectureDetailCubit>()
                      .getLectureDetail(state.lecture));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDetailsState.value = !showDetailsState.value,
        child: Icon(showDetailsState.value ? Icons.bar_chart : Icons.menu),
      ),
    );
  }
}

class _LectureDetailLoaded extends StatelessWidget {
  const _LectureDetailLoaded(
      {Key? key, required this.lecture, required this.showDetails})
      : super(key: key);

  final Lecture lecture;
  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<LectureDetailCubit>().getLectureDetail(lecture),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 4.0,
              ),
              itemCount: showDetails
                  ? lecture.detailList!.length
                  : lecture.gradeList!.length,
              itemBuilder: (BuildContext context, int index) {
                switch (showDetails) {
                  case true:
                    final lectureDetail = lecture.detailList![index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lectureDetail.name,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              lectureDetail.detail,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    );

                  case false:
                    final lectureGrade = lecture.gradeList![index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lectureGrade.name,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  if (lectureGrade.classAverage.isNotEmpty)
                                    Text(
                                      "Sınıf Ortalaması: " +
                                          lectureGrade.classAverage,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                ],
                              ),
                            ),
                            Text(
                              lectureGrade.note,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  default:
                    return Container();
                }

                // return ListTile(
                //   leading: const Icon(Icons.library_add),
                //   title: Text(lectureGrade.name),
                //   trailing: Text(lectureGrade.note),
                //   subtitle:
                //       Text('Sınıf ort: ${lectureGrade.classAverage}'),
                // );
              },
            ),
          ],
        ),
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
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.lecture.metaData.name,
                      ),
                      Text(
                        "Durum: " + state.lecture.metaData.success.successText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(.8)),
                      ),
                    ],
                  ),
                ),
              ],
            );
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
