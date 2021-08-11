import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/logic/cubits/line_chart/line_chart_cubit.dart';
import 'package:deucepte_open/presentation/screens/average/average_page.dart';
import 'package:deucepte_open/presentation/widgets/custom_card.dart';
import 'package:deucepte_open/presentation/widgets/lecture_statistics_linechart.dart';

class AverageCard extends StatelessWidget {
  const AverageCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: const Text(
        'Ortalama',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.insert_chart_outlined_outlined,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).push<dynamic>(
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const AveragePage(),
            ),
          ),
        )
      ],
      content: Column(
        children: <Widget>[
          const LectureStatisticsLineChart(),
          const Divider(),
          Builder(
            builder: (BuildContext context) {
              final lineChartCubit = context.watch<LineChartCubit>();
              final state = lineChartCubit.state;
              if (state.status == LineChartStatus.success) {
                final name = state.selectedLecture.metaData.name;
                final finalGrade = state.selectedLecture.finalGrade;
                return Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(finalGrade == null ? name : '$name: $finalGrade'),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
