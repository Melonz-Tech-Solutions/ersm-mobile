// @dart=2.9
import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'http.dart';

_showNotification(notification) {
  NotificationLayout notificationLayout = NotificationLayout.Default;
  if (notification.android.imageUrl != null &&
      notification.android.imageUrl != '[]') if (Uri.tryParse(
          json.decode(notification.android.imageUrl)['image']) !=
      null) notificationLayout = NotificationLayout.BigPicture;

  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 0,
          channelKey: 'basic_channel',
          title: notification.title,
          body: notification.body,
          notificationLayout: notificationLayout,
          bigPicture: notification.android.imageUrl != null &&
                  notification.android.imageUrl != '[]'
              ? json.decode(notification.android.imageUrl)['image']
              : null,
          wakeUpScreen: true,
          customSound:
              "https://res.cloudinary.com/dreame-rs-it-solutions-inc/video/upload/v1657354842/emergency/Alarm_sound_effect_pcs0ty.mp3?fbclid=IwAR1dD3A4bvLl4PMrHEXRxVncTVvyjA7pbXLyF0ik92fNpZ0_jIfxT6dlGSQ",
          displayOnBackground: true,
          displayOnForeground: true));
}

class FirebaseSettings {
  BuildContext context;

  init(BuildContext contextt) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    this.context = contextt;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data['notif'] == 'true')
        _showNotification(message.notification);
    });
    // if (_sharedPreference.getString('token') != null)
    // updateToken();
  }

  updateToken() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    if (_sharedPreference?.getString('token') == null) return;
    dynamic response;
    FirebaseMessaging _firebaseMessaging;
    _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.getToken().then((value) async {
      response =
          await Http(url: 'auth/fcm', body: {'token': value}).putWithHeader();
      print(json.decode(response.body)['message']);
      if (json.decode(response.body)['message'] == 'Unauthenticated.') {
        _sharedPreference.clear();
        return;
      }
    });
    return response;
  }

  revokeToken() async {
    dynamic response =
        await Http(url: 'auth/fcm/revoke', body: null).putWithHeader();
    return response;
  }
}
