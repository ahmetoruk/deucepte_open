import 'package:flutter/material.dart';

import 'package:deu_refectory_meals_api/deu_refectory_meals_api.dart';
import 'package:deucepte_open/logic/cubits/refectory/deu_refectory_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/presentation/widgets/shimmer_loading.dart';
import 'package:deucepte_open/presentation/widgets/custom_card.dart';

extension DateFilter on List<RefectoryDay> {
  // ignore: unnecessary_this
  Iterable<RefectoryDay> get currentRefectoryDays => this.where(
        (element) => element.dateTime.isAfter(
          DateTime.now().subtract(
            const Duration(days: 1),
          ),
        ),
      );
}

class RefectoryMealsCard extends StatelessWidget {
  const RefectoryMealsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Yemekhane Yemekler',
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () =>
              context.read<DeuRefectoryDetailCubit>().getRefectoryDays(),
        )
      ],
      content: BlocBuilder<DeuRefectoryDetailCubit, DeuRefectoryDetailState>(
        builder: (BuildContext context, DeuRefectoryDetailState state) {
          switch (state.status) {
            case DeuRefectoryDetailStatus.initial:
              return Container();
            case DeuRefectoryDetailStatus.loading:
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: ShimmerLoading(count: 1),
              );
            case DeuRefectoryDetailStatus.success:
              return Column(
                children: [
                  ...state.refectoryDays.currentRefectoryDays.map(
                    (e) => Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.date_range),
                          title: Text(
                            e.date,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(e.kcal),
                        ),
                        const Divider(
                          height: 0,
                        ),
                        ...e.meals.map(
                          (e) => Column(
                            children: [
                              ListTile(
                                leading:
                                    const Icon(Icons.restaurant_menu_outlined),
                                title: Text(e.title),
                              ),
                              const Divider(
                                height: 0,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            case DeuRefectoryDetailStatus.failure:
              return const ListTile(
                title: Text('Hata yemek listesi yüklenemedi!'),
              );
          }
        },
      ),
    );
  }
}
