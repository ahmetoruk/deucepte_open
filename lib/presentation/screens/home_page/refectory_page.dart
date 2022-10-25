import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/refectory_meals_card.dart';
import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/refectory_pos_card.dart';
import 'package:flutter/material.dart';

class RefectoryPage extends StatelessWidget {
  const RefectoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yemekhane'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        children: [
          RefectoryPosCard(),
          RefectoryMealsCard(),
        ],
      ),
    );
  }
}
