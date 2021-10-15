import 'package:flutter/material.dart';
import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/refectory_meals_card.dart';

import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/refectory_pos_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';

import 'package:deucepte_open/logic/cubits/auth/auth_cubit.dart';
import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/average_card.dart';
import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/messages_card.dart';
import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/notifications_card.dart';
import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/schedule_table_card.dart';
import 'package:deucepte_open/presentation/screens/login/logout_page.dart';
import 'package:deucepte_open/presentation/widgets/circle_progress_indicator.dart';
import 'package:deucepte_open/presentation/widgets/dialog.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    Key? key,
  }) : super(key: key);

  final loadingWidget = const SizedBox(
    height: 75,
    child: Center(
      child: CicleProgressIndicator(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anasayfa'),
        actions: <Widget>[
          IconButton(
            onPressed: () => showDialog<bool>(
              context: context,
              builder: (_) => ThemeConsumer(child: ThemeDialog()),
            ),
            icon: const Icon(Icons.color_lens),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => showAlertDialog(
              context,
              title: 'Çıkış',
              content:
                  'Çıkış yapmak ister misiniz? \n(Uyarı) Bütün bilgileriniz cihazınızdan silinecektir!',
              onConfirm: () {
                context.read<AuthCubit>().logout();
                Navigator.of(context).pushAndRemoveUntil<MaterialPageRoute>(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const LogoutPage(),
                    ),
                    (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        children: const <Widget>[
          AverageCard(),
          ScheduleTableCard(),
          NotificationsCard(),
          MessagesCard(),
          RefectoryPosCard(),
          RefectoryMealsCard()
        ],
      ),
    );
  }
}
