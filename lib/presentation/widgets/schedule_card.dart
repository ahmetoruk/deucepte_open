import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show ScheduleTextContainer;

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
    required this.tableList,
    required this.time,
    this.useCard = true,
    this.elevation = 1,
  }) : super(key: key);

  final List<ScheduleTextContainer> tableList;
  final String time;
  final double elevation;
  final bool useCard;

  @override
  Widget build(BuildContext context) {
    final innerWiget = IntrinsicHeight(
      child: Container(
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  time,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: tableList
                    .map(
                      (ScheduleTextContainer container) => Container(
                        padding: const EdgeInsets.all(2),
                        child: Text(container.text,
                            style: TextStyle(
                              fontWeight: container.bold
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
    return useCard
        ? Card(
            elevation: elevation,
            margin: const EdgeInsets.all(8.0),
            child: innerWiget)
        : innerWiget;
  }
}
