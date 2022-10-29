import 'dart:typed_data';

import 'package:deucepte_open/logic/cubits/lecture/lecture_notification_cubit.dart';
import 'package:deucepte_open/main.dart';
import 'package:deucepte_open/presentation/screens/lecture/lecture_notification_list_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/logic/cubits/auth/auth_cubit.dart';
import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/average_card.dart';
import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/messages_card.dart';
import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/schedule_table_card.dart';
import 'package:deucepte_open/presentation/screens/login/logout_page.dart';
import 'package:deucepte_open/presentation/widgets/circle_progress_indicator.dart';
import 'package:deucepte_open/presentation/widgets/dialog.dart';
import 'package:pdfx/pdfx.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 4),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(builder: (_) {
                final lectureNotificationCubit =
                    context.watch<LectureNotificationListCubit>();
                final state = lectureNotificationCubit.state;
                return Expanded(
                  child: GestureDetector(
                    onTap: state.lectureNotifications.isEmpty
                        ? null
                        : () {
                            Navigator.of(context)
                                .push<dynamic>(MaterialPageRoute<Widget>(
                              builder: (BuildContext context) =>
                                  const LectureNotificationListPage(),
                            ));
                          },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.notifications_active,
                                  size: 50,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.25),
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.25),
                                  child: Text(
                                    state.lectureNotifications.length
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.8)),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Aktif bildirimler",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) => FutureBuilder(
                        future: deuApi.lecture.fetchTranscript(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Uint8List> snapshot) {
                          if (snapshot.hasData) {
                            return Stack(
                              children: [
                                PdfView(
                                  controller: PdfController(
                                    document:
                                        PdfDocument.openData(snapshot.data!),
                                  ),
                                  scrollDirection: Axis.vertical,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Row(
                                    children: [
                                      const Opacity(
                                        opacity: 0.25,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.download,
                                            size: 40,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                          onPressed: null,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          size: 40,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return AlertDialog(
                              title: const Text('Hata'),
                              content: const Text(
                                  "Transkript yüklenirken hata oluştu!"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Tamam'),
                                ),
                              ],
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.article,
                                size: 50,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.25),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Transcriptim",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const AverageCard(),
          const ScheduleTableCard(),
          const MessagesCard(),
        ],
      ),
    );
  }
}
