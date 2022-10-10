import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:deu_api/deu_api.dart' show Lecture;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/core/constants/constants.dart';
import 'package:deucepte_open/logic/cubits/line_chart/line_chart_cubit.dart';

class LectureStatisticsLineChart extends StatelessWidget {
  const LectureStatisticsLineChart({
    Key? key,
  }) : super(key: key);

  List<charts.Series<Lecture, num>> generateSeries(
      BuildContext context, List<Lecture> data) {
    return [
      charts.Series<Lecture, num>(
        id: 'Grades',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            Theme.of(context).colorScheme.primary),
        domainFn: (Lecture lecture, int? index) => index ?? 0,
        measureFn: (Lecture lecture, _) {
          if (lecture.finalGrade != null) {
            final letterIndex = letterGradeList.indexOf(lecture.finalGrade!);
            final mult = 4 - (letterIndex * 0.5);
            return mult;
          }
          return 0;
        },
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LineChartCubit, LineChartState>(
      buildWhen: (LineChartState previousState, LineChartState state) {
        if (previousState.status == LineChartStatus.initial) {
          return true;
        } else {
          return false;
        }
      },
      builder: (BuildContext context, LineChartState state) {
        if (state.status == LineChartStatus.success) {
          return SizedBox(
            height: 200,
            child: charts.LineChart(
              generateSeries(context, state.lectures),
              animate: false,
              defaultRenderer: charts.LineRendererConfig(includePoints: true),
              selectionModels: [
                charts.SelectionModelConfig(
                  changedListener: (charts.SelectionModel model) {
                    final index = model.selectedSeries[0]
                        .domainFn(model.selectedDatum[0].index) as int;
                    context.read<LineChartCubit>().selectLecture(index);
                  },
                ),
              ],
              behaviors: [
                charts.SelectNearest(
                  eventTrigger: charts.SelectionTrigger.tapAndDrag,
                )
              ],
              primaryMeasureAxis: charts.NumericAxisSpec(
                renderSpec: charts.GridlineRendererSpec(
                  labelAnchor: charts.TickLabelAnchor.centered,
                  labelStyle: charts.TextStyleSpec(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const charts.Color(r: 255, g: 255, b: 255, a: 200)
                        : const charts.Color(r: 0, g: 0, b: 0, a: 150),
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const charts.Color(r: 255, g: 255, b: 255, a: 200)
                        : const charts.Color(r: 0, g: 0, b: 0, a: 150),
                    thickness: 1,
                  ),
                ),
                tickProviderSpec: const charts.StaticNumericTickProviderSpec(
                  <charts.TickSpec<num>>[
                    charts.TickSpec(0,
                        label: 'FF', style: charts.TextStyleSpec(fontSize: 14)),
                    charts.TickSpec(0.5,
                        label: 'FD', style: charts.TextStyleSpec(fontSize: 14)),
                    charts.TickSpec(1.0,
                        label: 'DD', style: charts.TextStyleSpec(fontSize: 14)),
                    charts.TickSpec(1.5,
                        label: 'DC', style: charts.TextStyleSpec(fontSize: 14)),
                    charts.TickSpec(2.0,
                        label: 'CC', style: charts.TextStyleSpec(fontSize: 14)),
                    charts.TickSpec(2.5,
                        label: 'CB', style: charts.TextStyleSpec(fontSize: 14)),
                    charts.TickSpec(3.0,
                        label: 'BB', style: charts.TextStyleSpec(fontSize: 14)),
                    charts.TickSpec(3.5,
                        label: 'BA', style: charts.TextStyleSpec(fontSize: 14)),
                    charts.TickSpec(4.0,
                        label: 'AA', style: charts.TextStyleSpec(fontSize: 14)),
                  ],
                ),
              ),
              domainAxis: charts.NumericAxisSpec(
                renderSpec: charts.GridlineRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const charts.Color(r: 255, g: 255, b: 255, a: 200)
                        : const charts.Color(r: 0, g: 0, b: 0, a: 150),
                  ),
                  lineStyle: const charts.LineStyleSpec(
                    color: charts.MaterialPalette.transparent,
                  ),
                ),
              ),
            ),
          );
        }
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: const Center(
            child: Text(
                'Ortalama grafiğini yüklemek için ortalama hesaplayıcıyı başlatın.'),
          ),
        );
      },
    );
  }
}
