import 'dart:io';
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
import 'package:share_plus/share_plus.dart';

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
          if (Platform.isAndroid)
            GestureDetector(
              onTap: () {
                Share.share(
                  "DEU Cepte uygulaması artık IOS'ta! https://apps.apple.com/tr/app/deu-cepte-dokuz-eyl%C3%BCl-%C3%BCni/id1662538631?l=tr",
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.apple,
                            size: 50,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.70),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "DEU Cepte App Store'da!",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.share,
                            size: 24,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.80),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Arkadaşlarına paylaşarak DEU Cepte'nin daha çok kullanılmasına yardımcı olabilirsin.",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.80)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // InkWell(
          //   onTap: () {
          //     launchUrl(
          //         Uri.parse('https://linkedin.com/in/ahmet-örük-7244521a4'));
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       children: [
          //         Spacer(),
          //         Icon(
          //           Icons.person_add,
          //           color: Color(0xFF0A66C2),
          //           size: 24,
          //         ),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Text("LinkedIn profilim",
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .titleMedium
          //                 ?.copyWith(fontWeight: FontWeight.w900))
          //       ],
          //     ),
          //   ),
          // ),
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
