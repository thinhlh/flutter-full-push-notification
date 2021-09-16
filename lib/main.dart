import 'package:demo_alarm/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  tz.initializeTimeZones();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(builder: (ctx) {
          return Center(
            child: GestureDetector(
              onTap: () async {
                NotificationHelper.showNotification();
              },
              child: Image.asset(
                'assets/images/image.png',
                fit: BoxFit.contain,
              ),
            ),
          );
        }),
      ),
    );
  }
}
