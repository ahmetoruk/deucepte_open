import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show Lecture, Semester;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/core/constants/constants.dart';
import 'package:deucepte_open/core/extensions/lecture.dart';
import 'package:deucepte_open/logic/cubits/average/average_calc_cubit.dart';

class AverageCalculator extends StatelessWidget {
  const AverageCalculator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AverageCalcCubit, AverageCalcState>(
      builder: (BuildContext context, AverageCalcState state) {
        switch (state.status) {
          case AverageCalcStatus.initial:
            return Container();
          case AverageCalcStatus.success:
            return _AverageCalcLoaded(
              semesters: state.semesters,
              lectures: state.lectures,
            );
        }
      },
    );
  }
}

class _AverageCalcLoaded extends StatelessWidget {
  const _AverageCalcLoaded(
      {Key? key, required this.semesters, required this.lectures})
      : super(key: key);

  final List<Semester> semesters;
  final List<Lecture> lectures;

  @override
  Widget build(BuildContext context) {
    final nonSelectedLectureCount =
        lectures.where((element) => element.finalGrade! == '--').length;
    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: semesters.map(
              (Semester semester) {
                final semesterLectures = lectures.filterBySemester(semester);
                if (semesterLectures.isNotEmpty) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ...semesterLectures.map<Widget>(
                          (Lecture lecture) => Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  Icons.library_books,
                                  color: lecture.averageColor,
                                ),
                                title: Text(
                                  lecture.metaData.name +
                                      (lecture.finalGrade !=
                                              lecture.initialFinalGrade
                                          ? ' [${lecture.initialFinalGrade!.isNotEmpty ? lecture.initialFinalGrade : '--'}]'
                                          : ''),
                                ),
                                subtitle: Text('Kredi: ${lecture.credit}'),
                                trailing: DropdownButton<String>(
                                  underline: Container(),
                                  onChanged: (String? newGrade) => context
                                      .read<AverageCalcCubit>()
                                      .updateGrade(lecture, newGrade!),
                                  value: lecture.finalGrade!.isNotEmpty
                                      ? lecture.finalGrade
                                      : '--',
                                  items: letterGradeList
                                      .map(
                                        (String grade) =>
                                            DropdownMenuItem<String>(
                                          value: grade,
                                          child: Text(
                                            grade,
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              const Divider(
                                height: 1,
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          title: const Text('Dönem ortalaması'),
                          trailing: Text(
                            semester.average == null
                                ? ''
                                : semester.average!.toStringAsFixed(2),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ).toList(),
          ),
        ),
        nonSelectedLectureCount > 0
            ? ListTile(
                leading: const Icon(Icons.warning),
                title: Text('$nonSelectedLectureCount derse not seçiniz!'),
              )
            : const ListTile(
                leading: Icon(Icons.mood),
                title: Text('Varsa kredisiz derslerinize not girmeyiniz!'),
              )
      ],
    );
  }
}
