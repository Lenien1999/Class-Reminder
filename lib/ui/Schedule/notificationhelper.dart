import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../backend/schedule/schedulemodel.dart';
import '../../main.dart';

class NotificationHelper{

  void scheduleAlarm(
    DateTime scheduledNotificationDateTime,
    String title,
    String decsription
  ) async {
    // int newTime = minutes;
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('logo'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
       decsription,

      // convertTime(hour, minutes),
      tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

}

//  DBHelper _dbHelper = DBHelper();

//   Future<List<LecturerTask>>? _task;
//   List<LecturerTask>? _currenttask;
//   @override
//   void initState() {
//     _dbHelper.initializeDatabase().then((value) {
//       print('------database intialized');
//       loadtask();
//     });
//     super.initState();
//   }

//   void loadtask() {
//     _task = _dbHelper.QuerySchedule();
//     if (mounted) setState(() {});
//   }