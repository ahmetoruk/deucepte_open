import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show Semester;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:deucepte_open/logic/cubits/lecture/lecture_list_cubit.dart';
import 'package:deucepte_open/logic/cubits/semester/semester_cubit.dart';
import 'package:deucepte_open/presentation/screens/lecture/lecture_list_page.dart';
import 'package:deucepte_open/presentation/widgets/connection_error.dart';
import 'package:deucepte_open/presentation/widgets/shimmer_loading.dart';

class SemesterListPage extends StatelessWidget {
  const SemesterListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Derslerim'),
      ),
      body: BlocBuilder<SemesterListCubit, SemesterListState>(
        builder: (BuildContext context, SemesterListState state) {
          switch (state.status) {
            case SemesterListStatus.initial:
              return Container();
            case SemesterListStatus.loading:
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: ShimmerLoading(
                  count: 6,
                ),
              );
            case SemesterListStatus.success:
              return _SemesterListLoaded(
                semesters: state.semesters,
              );
            case SemesterListStatus.failure:
              return ConnectionError(
                fetch: () => context.read<SemesterListCubit>().getSemesters(),
              );
          }
        },
      ),
    );
  }
}

class _SemesterListLoaded extends StatelessWidget {
  const _SemesterListLoaded({
    Key? key,
    required this.semesters,
  }) : super(key: key);
  final List<Semester> semesters;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 0,
      ),
      itemCount: semesters.length,
      itemBuilder: (BuildContext context, int index) {
        final semester = semesters[index];
        return ListTile(
          title: Text(semester.name),
          leading: const Icon(Icons.date_range),
          onTap: () => _onTapSemester(context, semester),
        );
      },
    );
  }

  void _onTapSemester(BuildContext context, Semester semester) async {
    context.loaderOverlay.show();
    await context.read<LectureListCubit>().getLectureList(semester);
    context.loaderOverlay.hide();
    Navigator.of(context).push<dynamic>(
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => const LectureListPage(),
      ),
    );
  }
}
