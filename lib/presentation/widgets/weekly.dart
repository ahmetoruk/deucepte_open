import 'package:deu_pos_api/deu_pos_api.dart';
import 'package:flutter/material.dart';

class WeeklyWidget extends StatelessWidget {
  const WeeklyWidget(
    this.weekly, {
    Key? key,
  }) : super(key: key);
  final Weekly weekly;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(weekly.date),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          WeeklyButton("P", weekly.weeklyDays["P.tesi"] == true),
          WeeklyButton("S", weekly.weeklyDays["Salı"] == true),
          WeeklyButton("Ç", weekly.weeklyDays["Çarş."] == true),
          WeeklyButton("P", weekly.weeklyDays["Perş."] == true),
          WeeklyButton("C", weekly.weeklyDays["Cuma"] == true)
        ],
      ),
    );
  }
}

class WeeklyButton extends StatelessWidget {
  const WeeklyButton(
    this.name,
    this.active, {
    Key? key,
  }) : super(key: key);
  final String name;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: active ? Colors.purple : Colors.purple.withOpacity(0.3),
        width: 25,
        height: 25,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
