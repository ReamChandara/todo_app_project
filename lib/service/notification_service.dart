import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotifyHelper {
  BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  final localNotificationService = FlutterLocalNotificationsPlugin();
  Future<void> intialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('appicon');

    DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await localNotificationService.initialize(settings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

  Future<NotificationDetails> _notificationDetail() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );
    const DarwinNotificationDetails iosNoticationDetail =
        DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNoticationDetail,
    );
  }

  Future<void> showNotification(
      {required int id, required title, required String body}) async {
    final detail = await _notificationDetail();
    await localNotificationService.show(id, title, body, detail);
  }

  Future<void> showSchedleNotification(
      {required int id,
      required title,
      required String body,
      required int second}) async {
    final detail = await _notificationDetail();
    await localNotificationService.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
            DateTime.now().add(Duration(seconds: second)), tz.local),
        detail,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await _notificationDetail();
    await localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  Future<void> repeatNotification(int id) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'repeating channel id', 'repeating channel name',
            channelDescription: 'repeating description');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await localNotificationService.periodicallyShow(id++, 'repeating title',
        'repeating body', RepeatInterval.everyMinute, notificationDetails,
        androidAllowWhileIdle: true);
  }

  Future<void> cancelAllNotifications() async {
    await localNotificationService.cancelAll();
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    print("payload ${notificationResponse.payload}");
    if (notificationResponse.payload != null &&
        notificationResponse.payload!.isNotEmpty) {
      onNotificationClick.add(notificationResponse.payload);
    }
  }
}
