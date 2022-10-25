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
    return BlocBuilder<DeuRefectoryDetailCubit, DeuRefectoryDetailState>(
      builder: (BuildContext context, DeuRefectoryDetailState state) {
        switch (state.status) {
          case DeuRefectoryDetailStatus.initial:
            return Container();
          case DeuRefectoryDetailStatus.loading:
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: ShimmerLoading(count: 5),
            );
          case DeuRefectoryDetailStatus.success:
            return Column(
              children: [
                ...state.refectoryDays.currentRefectoryDays.map(
                  (e) => Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.8),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                e.date,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.8),
                                    ),
                              )
                            ],
                          ),
                          trailing: Text(e.kcal,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.4),
                                  )),
                        ),
                        const Divider(
                          height: 0,
                        ),
                        ...e.meals.map(
                          (e) => Column(
                            children: [
                              ListTile(
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.restaurant_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.4)),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(e.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 0,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          case DeuRefectoryDetailStatus.failure:
            return const ListTile(
              title: Text('Hata yemek listesi yüklenemedi!'),
            );
        }
      },
    );
  }
}
