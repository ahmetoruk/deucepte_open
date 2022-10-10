import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show ScheduleTextContainer;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/logic/cubits/schedule/schedule_cubit.dart';
import 'package:deucepte_open/presentation/screens/schedule/schedule_page.dart';
import 'package:deucepte_open/presentation/widgets/custom_card.dart';
import 'package:deucepte_open/presentation/widgets/schedule_card.dart';
import 'package:deucepte_open/presentation/widgets/shimmer_loading.dart';

class ScheduleTableCard extends StatelessWidget {
  const ScheduleTableCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Ders Programı',
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => context.read<ScheduleCubit>().getScheduleTable(),
        )
      ],
      content: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (BuildContext context, ScheduleState state) {
          switch (state.status) {
            case ScheduleStatus.initial:
              return Container();
            case ScheduleStatus.loading:
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: ShimmerLoading(count: 1),
              );
            case ScheduleStatus.success:
              return _ScheduleCardLoaded(
                scheduleTable: state.scheduleTable,
                currentLecture: state.currentLecture,
              );
            case ScheduleStatus.failure:
              return const ListTile(
                title: Text('Hata ders programı yüklenemedi!'),
              );
          }
        },
      ),
    );
  }
}

class _ScheduleCardLoaded extends StatelessWidget {
  const _ScheduleCardLoaded(
      {Key? key, required this.scheduleTable, required this.currentLecture})
      : super(key: key);

  final List<List<List<ScheduleTextContainer>>> scheduleTable;
  final CurrentScheduleLecture? currentLecture;

  @override
  Widget build(BuildContext context) {
    if (currentLecture != null) {
      try {
        final tableList =
            scheduleTable[currentLecture!.rowIndex][currentLecture!.dayOfWeek];
        final time = scheduleTable[currentLecture!.rowIndex]
            .first
            .first
            .text
            .replaceFirst(' ', '\n');
        return Column(
          children: [
            ScheduleCard(
              tableList: tableList,
              time: time,
              useCard: false,
              elevation: 0,
            ),
            const Divider(
              height: 0,
            ),
            ListTile(
              title: const Text('Detaylı ders programı'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => Navigator.of(context).push<dynamic>(
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) => const SchedulePage(),
                ),
              ),
            )
          ],
        );
      } catch (e) {
        return const ListTile(
          title: Text('Ders programı yüklenirken beklenmedik bir hata oluştu!'),
        );
      }
    }
    return Container();
  }
}
