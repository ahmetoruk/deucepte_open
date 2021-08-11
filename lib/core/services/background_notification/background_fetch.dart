import 'package:background_fetch/background_fetch.dart';
import 'package:deu_api/deu_api.dart' show DeuApi;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:deucepte_open/data/repositories/lecture_notification_repository.dart';
import 'package:deucepte_open/logic/cubits/auth/auth_cubit.dart';
import 'package:deucepte_open/logic/cubits/lecture/lecture_notification_cubit.dart';

void initBackgroundFetch({required Function callback}) async {
  final status = await BackgroundFetch.configure(
      BackgroundFetchConfig(
          minimumFetchInterval: 15,
          startOnBoot: true,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.ANY), (String taskId) async {
    print('[BackgroundFetch] Event received $taskId');
    await callback();
    BackgroundFetch.finish(taskId);
  }, (String taskId) async {
    print('[BackgroundFetch] TASK TIMEOUT taskId: $taskId');
    BackgroundFetch.finish(taskId);
  });
  print('[BackgroundFetch] configure success: $status');
}

void headlessNotificationFetch(HeadlessTask task) async {
  try {
    final sharedPreferences = await SharedPreferences.getInstance();
    final api = DeuApi.create(sharedPreferences);
    final authCubit = AuthCubit(api.auth, sharedPreferences);
    final lectureNotificationRepository =
        LectureNotificationRepository(sharedPreferences);
    final lectureNotificationListCubit = LectureNotificationListCubit(
        lectureNotificationRepository, api.lecture);
    lectureNotificationListCubit.getNotifications();
    if (lectureNotificationListCubit.state.lectureNotifications.isNotEmpty) {
      await authCubit.autoLogin();
      await Future<void>.delayed(const Duration(seconds: 1));
      await lectureNotificationListCubit.checkNotifications();
    }
  } catch (e) {
    print(e);
  }
  BackgroundFetch.finish(task.taskId);
}
