import 'package:demo_alarm/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

/// Singleton pattern
class NotificationHelper {
  static FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;

  NotificationHelper._() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = const IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = InitializationSettings(android: android, iOS: IOS);
    _flutterLocalNotificationsPlugin?.initialize(settings);
  }

  static Future showNotification() async {
    if (_flutterLocalNotificationsPlugin == null) {
      NotificationHelper._();
    }

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      Constants.CHANNEL_ID,
      Constants.CHANNEL_NAME,
      Constants.CHANNEL_DESCRIPTION,
      importance: Importance.high,
      priority: Priority.max,
      // Enable this to get full screen when receive notification
      fullScreenIntent: true,
      largeIcon: DrawableResourceAndroidBitmap('flutter'),
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin?.zonedSchedule(
      Constants.NOTIFICATION_ID,
      Constants.NOTIFICATION_TITLE,
      Constants.NOTIFICATION_BODY,
      tz.TZDateTime.now(tz.local).add(
        const Duration(
          seconds: Constants.NOTIFICATION_DURATION,
        ),
      ),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
