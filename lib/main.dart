// @dart=2.9
import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:zamboangaemergency/default/config.dart';
import 'package:zamboangaemergency/default/firebase_settings.dart';
import 'package:zamboangaemergency/splashscreen.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hive_flutter/hive_flutter.dart';

Database database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences for Web
  // Future<void> initializeSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   if (!prefs.containsKey('responder_types')) {
  //     // Define default responder types
  //     List<Map<String, dynamic>> responderTypes = [
  //       {
  //         'id': 1,
  //         'name': 'Firefighter',
  //         'description': 'Responds to fire emergencies',
  //         'map_icon': 'fire_icon.png',
  //         'nav_icon': 'fire_nav.png',
  //       },
  //       {
  //         'id': 2,
  //         'name': 'Police',
  //         'description': 'Responds to law enforcement emergencies',
  //         'map_icon': 'police_icon.png',
  //         'nav_icon': 'police_nav.png',
  //       },
  //     ];

  //     // Store responder types as a JSON string
  //     prefs.setString('responder_types', jsonEncode(responderTypes));
  //   }
  // }

  // if (kIsWeb) {
  //   await initializeSharedPreferences();
  // } else {
  //   var databasesPath = await getDatabasesPath();
  //   String path = join(databasesPath, 'zamboangarescue.db');
  //   database = await openDatabase(
  //     path,
  //     onCreate: (db, version) {
  //       return db.execute(
  //           'CREATE TABLE responder_types(id INTEGER PRIMARY KEY, name STRING, description TEXT, map_icon TEXT, nav_icon TEXT)');
  //     },
  //     version: 1,
  //   );
  // }

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

  // if (kIsWeb) {
  //   // Use Hive for web
  //   await Hive.init('zamboangarescue');
  //   var box = await Hive.openBox('zamboangarescue');
  //   print('Web: Hive initialized');
  // } else {
  //   // Use sqflite for mobile
  //   var databasesPath = await getDatabasesPath();
  //   String path = join(databasesPath, 'zamboangarescue.db');

  //   database = await openDatabase(
  //     path,
  //     onCreate: (db, version) {
  //       return db.execute(
  //           'CREATE TABLE responder_types(id INTEGER PRIMARY KEY, name STRING, description TEXT, map_icon TEXT, nav_icon TEXT)');
  //     },
  //     version: 1,
  //   );

  //   print('Mobile: sqflite database initialized');
  // }
  // databaseFactory = databaseFactoryFfi;
  // var databasesPath = await databaseFactory.getDatabasesPath();
  // String path = join(databasesPath, 'zamboangarescue.db');

  // database = await databaseFactory.openDatabase(
  //   path,
  //   options: OpenDatabaseOptions(
  //     onCreate: (db, version) {
  //       return db.execute(
  //           'CREATE TABLE responder_types(id INTEGER PRIMARY KEY, name STRING, description TEXT, map_icon TEXT, nav_icon TEXT)');
  //     },
  //     version: 1,
  //   ),
  // );

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

  // await Firebase.initializeApp();
  runApp(
    DevicePreview(
      // White background looks professional in website embedding
      backgroundColor: Colors.white,

      // Enable preview by default for web demo
      enabled: !kReleaseMode,

      // Start with Galaxy A50 as it's a common Android device
      defaultDevice: Devices.ios.iPhone13ProMax,

      // Show toolbar to let users test different devices
      isToolbarVisible: true,

      // Keep English only to avoid confusion in demos
      availableLocales: [Locale('en', 'US')],

      // Customize preview controls
      tools: const [
        // Device selection controls
        DeviceSection(
          model: true, // Option to change device model to fit your needs
          orientation: false, // Lock to portrait for consistent demo
          frameVisibility: false, // Hide frame options
          virtualKeyboard: false, // Hide keyboard
        ),

        // Theme switching section
        // SystemSection(
        //   locale: false, // Hide language options - we're keeping it English only
        //   theme: false, // Show theme switcher if your app has dark/light modes
        // ),

        // Disable accessibility for demo simplicity
        // AccessibilitySection(
        //   boldText: false,
        //   invertColors: false,
        //   textScalingFactor: false,
        //   accessibleNavigation: false,
        // ),

        // Hide extra settings to keep demo focused
        // SettingsSection(
        //   backgroundTheme: false,
        //   toolsTheme: false,
        // ),
      ],

      // Curated list of devices for comprehensive preview
      devices: [
        // ... Devices.all, // uncomment to see all devices

        // Popular Android Devices
        Devices.android.samsungGalaxyA50, // Mid-range
        Devices.android.samsungGalaxyNote20, // Large screen
        Devices.android.samsungGalaxyS20, // Flagship
        Devices.android.samsungGalaxyNote20Ultra, // Premium
        Devices.android.onePlus8Pro, // Different aspect ratio
        Devices.android.sonyXperia1II, // Tall screen

        // Popular iOS Devices
        Devices.ios.iPhoneSE, // Small screen
        Devices.ios.iPhone12, // Standard size
        Devices.ios.iPhone12Mini, // Compact
        Devices.ios.iPhone12ProMax, // Large
        Devices.ios.iPhone13, // Latest standard
        Devices.ios.iPhone13ProMax, // Latest large
        Devices.ios.iPhone13Mini, // Latest compact
        Devices.ios.iPhoneSE, // Budget option
      ],

      /// Your app's entry point
      builder: (context) => MyApp(),
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
            title: 'Flutter Auth',
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
