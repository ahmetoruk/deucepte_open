import 'package:deucepte_open/logic/cubits/refectory/deu_pos_cubit.dart';
import 'package:deucepte_open/presentation/widgets/shimmer_loading.dart';
import 'package:deucepte_open/presentation/widgets/weekly.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/presentation/widgets/custom_card.dart';

class RefectoryPosCard extends StatelessWidget {
  const RefectoryPosCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: const Text(
        'Yemekhane Bakiye ve Haftalık',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => context.read<DeuPosDetailCubit>().getDeuPosDetail(),
        )
      ],
      content: BlocBuilder<DeuPosDetailCubit, DeuPosDetailState>(
        builder: (BuildContext context, DeuPosDetailState state) {
          switch (state.status) {
            case DeuPosDetailStatus.initial:
              return Container();
            case DeuPosDetailStatus.loading:
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: ShimmerLoading(count: 1),
              );
            case DeuPosDetailStatus.success:
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.credit_card),
                    title: Text(
                      "${state.balanceInfo.credit}₺",
                    ),
                  ),
                  const Divider(
                    height: 0,
                  ),
                  if (state.balanceInfo.isWeekend)
                    const ListTile(
                      leading: Icon(Icons.warning),
                      title: Text("Haftasonu haftalık yükleme gösterilemiyor!"),
                    )
                  else
                    ...state.balanceInfo.weeklies.map(
                      (final weekly) => Column(
                        children: [
                          WeeklyWidget(weekly),
                          const Divider(
                            height: 0,
                          )
                        ],
                      ),
                    ),
                ],
              );

            case DeuPosDetailStatus.failure:
              return const ListTile(
                title: Text('Hata bakiye ve haftalık yüklenemedi!'),
              );
          }
        },
      ),
    );
  }
}
