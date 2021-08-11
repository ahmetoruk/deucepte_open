import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/logic/cubits/average/average_calc_cubit.dart';
import 'package:deucepte_open/logic/cubits/average/average_loading_cubit.dart';
import 'package:deucepte_open/presentation/screens/average/average_calculator.dart';

class AveragePage extends StatelessWidget {
  const AveragePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AverageCalcCubit, AverageCalcState>(
          builder: (BuildContext context, AverageCalcState state) {
            if (state.status == AverageCalcStatus.success) {
              return Text(state.finalAverage.toStringAsFixed(2));
            }
            return const Text('Yükleniyor..');
          },
        ),
      ),
      body: BlocBuilder<AverageLoadingCubit, AverageLoadingState>(
        builder: (BuildContext context, AverageLoadingState state) {
          switch (state.status) {
            case AverageLoadingStatus.initial:
              return Center(
                child: ElevatedButton(
                  onPressed: () =>
                      context.read<AverageLoadingCubit>().loadAverage(),
                  child: const Text('Ortalama hesaplayıcı başlat.'),
                ),
              );
            case AverageLoadingStatus.semestersLoading:
              return const Center(
                child: Text(
                  'Yükleniyor..',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              );
            case AverageLoadingStatus.semesterProgress:
            case AverageLoadingStatus.lectureProgress:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        state.status == AverageLoadingStatus.semesterProgress
                            ? state.currentSemester.name
                            : state.currentLecture.metaData.name,
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center),
                    Text(
                      '${state.current}/${state.total}',
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            case AverageLoadingStatus.success:
              return const AverageCalculator();
            case AverageLoadingStatus.failure:
              return Center(
                child: ElevatedButton(
                  onPressed: () =>
                      context.read<AverageLoadingCubit>().loadAverage(),
                  child: const Text('HATA! Yeniden dene'),
                ),
              );
          }
        },
      ),
    );
  }
}
