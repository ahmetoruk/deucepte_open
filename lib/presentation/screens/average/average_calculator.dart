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
    final nonSelectedLectureCount = lectures
        .where((element) => element.finalGrade! == '--' && element.disabled)
        .length;
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: <Widget>[
                          ...semesterLectures.map<Widget>(
                            (Lecture lecture) => Column(
                              children: <Widget>[
                                Opacity(
                                  opacity: !lecture.disabled ? 1 : 0.7,
                                  child: ListTile(
                                    title: Text(
                                      lecture.metaData.name +
                                          (lecture.finalGrade !=
                                                  lecture.initialFinalGrade
                                              ? ' [${lecture.initialFinalGrade!.isNotEmpty ? lecture.initialFinalGrade : '--'}]'
                                              : ''),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Kredi:",
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            DropdownButton<double>(
                                              underline: Container(),
                                              onChanged: (double? newGrade) {
                                                context
                                                    .read<AverageCalcCubit>()
                                                    .updateCredit(
                                                        lecture, newGrade!);
                                              },
                                              value: lecture.credit,
                                              items: List.generate(
                                                  13, (index) => index).map(
                                                (int note) {
                                                  final grade = note * 0.5;
                                                  return DropdownMenuItem<
                                                      double>(
                                                    value: grade,
                                                    child: Text(
                                                      grade.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 17),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                            Spacer(),
                                            TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<AverageCalcCubit>()
                                                      .toggleLecture(lecture);
                                                },
                                                child: Text(
                                                  lecture.disabled
                                                      ? 'Etkinleştir'
                                                      : 'Devre dışı bırak',
                                                  style: TextStyle(
                                                    color: lecture.disabled
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                ))
                                          ],
                                        ),
                                        Text(lecture.statusText!,
                                            style: TextStyle(
                                                color: lecture.averageColor)),
                                      ],
                                    ),
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
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 5,
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
                          ListTile(
                            title: const Text(
                                'Notlandırılmamış dönem derslerini CC yap'),
                            trailing: IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () => context
                                  .read<AverageCalcCubit>()
                                  .setAllSemesterLecturesToCC(semester),
                            ),
                          )
                        ],
                      ),
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
