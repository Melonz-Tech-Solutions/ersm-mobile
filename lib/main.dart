// @dart=2.9
import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:zamboangaemergency/default/config.dart';
import 'package:zamboangaemergency/default/firebase_settings.dart';
import 'package:zamboangaemergency/splashscreen.dart';

Database database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // var databasesPath = await getDatabasesPath();
  // String path = join(databasesPath, 'zamboangarescue.db');
  // database = await openDatabase(
  //   path,
  //   onCreate: (db, version) {
  //     return db.execute(
  //         'CREATE TABLE responder_types(id INTEGER PRIMARY KEY, name STRING, description TEXT, map_icon TEXT, nav_icon TEXT)');
  //   },
  //   version: 1,
  // );

  Future<void> initializeSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('responder_types')) {
      // Define default responder types
      List<Map<String, dynamic>> responderTypes = [
        {
          'id': 1,
          'name': 'Firefighter',
          'description': 'Responds to fire emergencies',
          'map_icon': 'fire_icon.png',
          'nav_icon': 'fire_nav.png',
        },
        {
          'id': 2,
          'name': 'Police',
          'description': 'Responds to law enforcement emergencies',
          'map_icon': 'police_icon.png',
          'nav_icon': 'police_nav.png',
        },
      ];

      // Store responder types as a JSON string
      prefs.setString('responder_types', jsonEncode(responderTypes));
    }
  }

  if (kIsWeb) {
    await initializeSharedPreferences();
  } else {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'zamboangarescue.db');
    database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE responder_types(id INTEGER PRIMARY KEY, name STRING, description TEXT, map_icon TEXT, nav_icon TEXT)');
      },
      version: 1,
    );
  }
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://mipmap/launcher_icon',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            defaultRingtoneType: DefaultRingtoneType.Alarm,
            soundSource: 'resource://raw/res_alarm',
            playSound: true,
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  AwesomeNotifications().requestPermissionToSendNotifications();
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      tools: [
        DeviceSection(
          model: true,
        ),
      ],
      devices: [...Devices.all],
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        FirebaseSettings().init(context);
        Config().init(constraints, orientation);
        // AwesomeNotifications().actionStream.listen(
        //     (ReceivedNotification receivedNotification){

        //         Navigator.of(context).pushNamed(
        //             '/NotificationPage',
        //             arguments: {
        //                 // your page params. I recommend you to pass the
        //                 // entire *receivedNotification* object
        //                 id: receivedNotification.id
        //             }
        //         );

        //     }
        // );
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Zamboanga Emergency Response',
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            theme: ThemeData(
              colorScheme: ThemeData().colorScheme.copyWith(
                    primary: Config.appColor,
                  ),
              scaffoldBackgroundColor: Colors.white,
            ),
            home: SplashScreen());
      });
    });
  }
}
