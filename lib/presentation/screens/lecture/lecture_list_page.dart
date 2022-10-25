import 'package:deucepte_open/presentation/widgets/forward_icon.dart';
import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show Lecture;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:deucepte_open/logic/cubits/lecture/lecture_detail_cubit.dart';
import 'package:deucepte_open/logic/cubits/lecture/lecture_list_cubit.dart';
import 'package:deucepte_open/presentation/screens/lecture/lecture_detail_page.dart';
import 'package:deucepte_open/presentation/widgets/connection_error.dart';
import 'package:deucepte_open/presentation/widgets/shimmer_loading.dart';

extension LectureSuccessX on String {
  String get successText {
    switch (this) {
      case 'B':
        return 'Başarılı';
      case 'X':
        return 'Başarısız';
      case 'A':
        return 'Alıyor';
      default:
        return this;
    }
  }
}

class LectureListPage extends StatelessWidget {
  const LectureListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _LectureListTitle(),
      ),
      body: BlocBuilder<LectureListCubit, LectureListState>(
        builder: (BuildContext context, LectureListState state) {
          switch (state.status) {
            case LectureListStatus.initial:
              return Container();
            case LectureListStatus.loading:
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: ShimmerLoading(
                  count: 6,
                ),
              );
            case LectureListStatus.success:
              return _LectureListLoaded(lectures: state.lectures);
            case LectureListStatus.failure:
              return ConnectionError(
                fetch: () => context
                    .read<LectureListCubit>()
                    .getLectureList(state.semester),
              );
          }
        },
      ),
    );
  }
}

class _LectureListLoaded extends StatelessWidget {
  const _LectureListLoaded({Key? key, required this.lectures})
      : super(key: key);
  final List<Lecture> lectures;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(4.0),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 4.0,
      ),
      itemCount: lectures.length,
      itemBuilder: (BuildContext context, int index) {
        final lecture = lectures[index];

        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _onTapLecture(context, lecture),
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
                          lecture.metaData.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        if (lecture.metaData.metaGrade.isNotEmpty)
                          Text("Not: " + lecture.metaData.metaGrade,
                              style: Theme.of(context).textTheme.bodySmall),
                        Text(
                          "Durum: " + lecture.metaData.success.successText,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const ForwardIcon()
                ],
              ),
            ),
          ),
        );
        // return ListTile(
        //   leading: const Icon(Icons.library_books),
        //   title: Text(lecture.metaData.name),
        //   subtitle: Text(lecture.metaData.success.successText),
        //   trailing: Text(lecture.metaData.metaGrade),
        //   onTap: () => _onTapLecture(context, lecture),
        // );
      },
    );
  }

  void _onTapLecture(BuildContext context, Lecture lecture) async {
    Navigator.of(context).push<dynamic>(
      MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const LectureDetailPage()),
    );
    context.read<LectureDetailCubit>().getLectureDetail(lecture);
  }
}

class _LectureListTitle extends StatelessWidget {
  const _LectureListTitle({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LectureListCubit, LectureListState>(
      builder: (BuildContext context, LectureListState state) {
        switch (state.status) {
          case LectureListStatus.initial:
            return Container();
          case LectureListStatus.loading:
            return const Text('Yükleniyor..');
          case LectureListStatus.success:
            return Text(state.semester.name);
          case LectureListStatus.failure:
            return const Text('Bağlantı hatası');
        }
      },
    );
  }
}
