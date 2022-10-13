import 'package:deu_pos_api/deu_pos_api.dart';
import 'package:deu_refectory_meals_api/deu_refectory_meals_api.dart';
import 'package:deucepte_open/core/themes/themes.dart';
import 'package:deucepte_open/data/repositories/deu_pos_repository.dart';
import 'package:deucepte_open/data/repositories/deu_refectory_meals_repository.dart';
import 'package:deucepte_open/logic/cubits/refectory/deu_pos_cubit.dart';
import 'package:deucepte_open/logic/cubits/refectory/deu_refectory_cubit.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show DeuApi;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:deucepte_open/data/repositories/average_repository.dart';
import 'package:deucepte_open/data/repositories/lecture_notification_repository.dart';
import 'package:deucepte_open/data/repositories/lecture_repository.dart';
import 'package:deucepte_open/data/repositories/message_repository.dart';
import 'package:deucepte_open/data/repositories/schedule_repository.dart';
import 'package:deucepte_open/data/repositories/semester_repository.dart';
import 'package:deucepte_open/logic/cubits/auth/auth_cubit.dart';
import 'package:deucepte_open/logic/cubits/average/average_calc_cubit.dart';
import 'package:deucepte_open/logic/cubits/average/average_loading_cubit.dart';
import 'package:deucepte_open/logic/cubits/lecture/lecture_detail_cubit.dart';
import 'package:deucepte_open/logic/cubits/lecture/lecture_list_cubit.dart';
import 'package:deucepte_open/logic/cubits/lecture/lecture_notification_cubit.dart';
import 'package:deucepte_open/logic/cubits/line_chart/line_chart_cubit.dart';
import 'package:deucepte_open/logic/cubits/message/message_detail_cubit.dart';
import 'package:deucepte_open/logic/cubits/message/message_list_cubit.dart';
import 'package:deucepte_open/logic/cubits/schedule/schedule_cubit.dart';
import 'package:deucepte_open/logic/cubits/semester/semester_cubit.dart';
import 'package:deucepte_open/presentation/screens/login/login_page.dart';

class App extends StatelessWidget {
  const App(
    this.api,
    this.deuPosApi,
    this.deuRefectoryMealsApi,
    this.sharedPreferences, {
    Key? key,
  }) : super(key: key);

  final DeuApi api;
  final DeuPosApi deuPosApi;
  final DeuRefectoryMealsApi deuRefectoryMealsApi;
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <RepositoryProvider>[
        RepositoryProvider<SemesterRepository>(
          create: (BuildContext context) => SemesterRepository(
            api.semester,
          ),
        ),
        RepositoryProvider<LectureRepository>(
          create: (BuildContext context) => LectureRepository(
            api.lecture,
          ),
        ),
        RepositoryProvider<AverageRepository>(
          create: (BuildContext context) => AverageRepository(
            api.lecture,
            sharedPreferences,
          ),
        ),
        RepositoryProvider<LectureNotificationRepository>(
          create: (BuildContext context) => LectureNotificationRepository(
            sharedPreferences,
          ),
        ),
        RepositoryProvider<MessageRepository>(
          create: (BuildContext context) => MessageRepository(
            api.message,
          ),
        ),
        RepositoryProvider<ScheduleRepository>(
          create: (BuildContext context) => ScheduleRepository(
            api.schedule,
            sharedPreferences,
          ),
        ),
        RepositoryProvider<DeuPosRepository>(
          create: (BuildContext context) => DeuPosRepository(
            deuPosApi,
            sharedPreferences,
          ),
        ),
        RepositoryProvider<DeuRefectoryMealsRepository>(
          create: (BuildContext context) =>
              DeuRefectoryMealsRepository(deuRefectoryMealsApi),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          return MultiBlocProvider(
            providers: <BlocProvider>[
              BlocProvider<AuthCubit>(
                create: (BuildContext context) => AuthCubit(
                  api.auth,
                  sharedPreferences,
                )..autoLogin(),
              ),
              BlocProvider<SemesterListCubit>(
                create: (BuildContext context) => SemesterListCubit(
                  context.read<SemesterRepository>(),
                )..getSemesters(),
              ),
              BlocProvider<LectureListCubit>(
                create: (BuildContext context) => LectureListCubit(
                  context.read<LectureRepository>(),
                ),
              ),
              BlocProvider<LectureDetailCubit>(
                create: (BuildContext context) => LectureDetailCubit(
                  context.read<LectureRepository>(),
                ),
              ),
              BlocProvider<AverageLoadingCubit>(
                create: (BuildContext context) => AverageLoadingCubit(
                  context.read<SemesterRepository>(),
                  context.read<AverageRepository>(),
                  sharedPreferences,
                ),
              ),
              BlocProvider<AverageCalcCubit>(
                create: (BuildContext context) => AverageCalcCubit(
                  context.read<AverageLoadingCubit>(),
                ),
              ),
              BlocProvider<MessageListCubit>(
                create: (BuildContext context) => MessageListCubit(
                  context.read<MessageRepository>(),
                )..getMessageList(),
              ),
              BlocProvider<MessageDetailCubit>(
                create: (BuildContext context) => MessageDetailCubit(
                  context.read<MessageRepository>(),
                ),
              ),
              BlocProvider<ScheduleCubit>(
                create: (BuildContext context) => ScheduleCubit(
                  context.read<ScheduleRepository>(),
                )..getScheduleTable(cache: true),
              ),
              BlocProvider<LectureNotificationListCubit>(
                create: (BuildContext context) => LectureNotificationListCubit(
                    context.read<LectureNotificationRepository>(), api.lecture)
                  ..getNotifications()
                  ..startBackgroundFetch(),
              ),
              BlocProvider<LineChartCubit>(
                create: (BuildContext context) => LineChartCubit(
                  context.read<AverageLoadingCubit>(),
                  sharedPreferences,
                )..getLineChartData(),
              ),
              BlocProvider<DeuPosDetailCubit>(
                create: (BuildContext context) => DeuPosDetailCubit(
                  context.read<DeuPosRepository>(),
                )..getDeuPosDetail(),
              ),
              BlocProvider<DeuRefectoryDetailCubit>(
                create: (BuildContext context) => DeuRefectoryDetailCubit(
                  context.read<DeuRefectoryMealsRepository>(),
                )..getRefectoryDays(),
              ),
            ],
            child: GlobalLoaderOverlay(
              overlayColor: Colors.black,
              overlayOpacity: 0.1,
              useDefaultLoading: true,
              overlayWidget: const Center(
                child: CircularProgressIndicator(),
              ),
              child: DynamicColorBuilder(
                builder:
                    (ColorScheme? lightDynamic, ColorScheme? darkDynamic) =>
                        MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'DEU Cepte',
                  theme:
                      ThemeData(useMaterial3: true, colorScheme: lightDynamic),
                  darkTheme:
                      ThemeData(useMaterial3: true, colorScheme: darkDynamic),
                  themeMode: ThemeMode.system,
                  home: const LoginPage(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
