import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show ScheduleTextContainer;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/logic/cubits/schedule/schedule_cubit.dart';
import 'package:deucepte_open/presentation/widgets/connection_error.dart';
import 'package:deucepte_open/presentation/widgets/schedule_card.dart';
import 'package:deucepte_open/presentation/widgets/shimmer_loading.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ders Programı'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Pzt',
              ),
              Tab(
                text: 'Sal',
              ),
              Tab(
                text: 'Çar',
              ),
              Tab(
                text: 'Per',
              ),
              Tab(
                text: 'Cum',
              ),
            ],
          ),
        ),
        body: BlocBuilder<ScheduleCubit, ScheduleState>(
          builder: (BuildContext context, ScheduleState state) {
            switch (state.status) {
              case ScheduleStatus.initial:
                return Container();
              case ScheduleStatus.loading:
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ShimmerLoading(
                    count: 8,
                  ),
                );
              case ScheduleStatus.success:
                return _ScheduleLoaded(
                  scheduleTable: state.scheduleTable,
                );
              case ScheduleStatus.failure:
                return ConnectionError(
                  fetch: () => context.read<ScheduleCubit>().getScheduleTable(),
                );
            }
          },
        ),
      ),
    );
  }
}

class _ScheduleLoaded extends StatelessWidget {
  const _ScheduleLoaded({
    Key? key,
    required this.scheduleTable,
  }) : super(key: key);

  final List<List<List<ScheduleTextContainer>>> scheduleTable;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        ...<int>[1, 2, 3, 4, 5].map(
          (int i) => ListView.builder(
            itemCount: scheduleTable.length,
            itemBuilder: (BuildContext context, int index) {
              final tableList = scheduleTable[index][i];
              final time =
                  scheduleTable[index].first.first.text.replaceFirst(' ', '\n');
              return ScheduleCard(
                tableList: tableList,
                time: time,
              );
            },
          ),
        )
      ],
    );
  }
}
