import 'package:deucepte_open/logic/cubits/lecture/lecture_notification_cubit.dart';
import 'package:deucepte_open/presentation/screens/lecture/lecture_notification_list_page.dart';
import 'package:deucepte_open/presentation/widgets/button_with_badge.dart';
import 'package:flutter/material.dart';
import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/refectory_meals_card.dart';

import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/refectory_pos_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/logic/cubits/auth/auth_cubit.dart';
import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/average_card.dart';
import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/messages_card.dart';
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
        children: <Widget>[
          Row(
            children: [
              const Spacer(),
              BlocBuilder<LectureNotificationListCubit,
                      LectureNotificationListState>(
                  builder: (_, state) => state.lectureNotifications.isNotEmpty
                      ? ButtonWithBadge(
                          badgeCount: state.lectureNotifications.length,
                          onPressed: state.lectureNotifications.isEmpty
                              ? null
                              : () {
                                  Navigator.of(context)
                                      .push<dynamic>(MaterialPageRoute<Widget>(
                                    builder: (BuildContext context) =>
                                        const LectureNotificationListPage(),
                                  ));
                                },
                          child: const Text("Aktif bildirimler"),
                        )
                      : Container())
            ],
          ),
          const AverageCard(),
          const ScheduleTableCard(),
          const MessagesCard(),
          const RefectoryPosCard(),
          const RefectoryMealsCard()
        ],
      ),
    );
  }
}
