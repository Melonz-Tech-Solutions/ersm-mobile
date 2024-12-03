// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

class Http {
  SharedPreferences _sharedPreferences;
  // String ip = '192.168.68.102';
  // String ip = '134.209.155.217';
  String ip = 'zamboangarescue.org';
  final String url;
  final dynamic body;

  Http({this.url, this.body});

  sendFCM(double lat, double lng) async {
    dynamic _response;
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await http.post(
          Uri(scheme: 'https', host: 'fcm.googleapis.com', path: 'fcm/send'),
          body: json.encode({
            "notification": {
              "body": "There is an emergency report!",
              "title": "EMERGENCY REPORT!"
            },
            "priority": "high",
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "notif": false,
              "lat": lat,
              "lng": lng
            },
            "to":
                "fH62gvHVRPuSp8uWfeeJET:APA91bEzA1HqGVPSo2860IOXM98DHjMia13fa_7rNBEiTEAN97qAj4mVLOPWO2BZz_YMa1fBs9WQ2YC44GHdVKIkya7870kUlEB8F5gnNM94Kh9Pgw8CTkSy9MYC05Vn5-w929M1U7JJ"
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                'key=AAAAM_pO_18:APA91bFfxvruAkD8mqgGJtwfi9TADbarIObqIx9XRwwf5KdJ9G73YWe6U7ZGvIvZ3bA9LyXDiPx-tKxqmyV8cN3FQolh1cv4nHazhFHaLTSq9iHj-uT0mO7YTF8yTTxDrpuEF116PIpu'
          }).then((response) {
        _response = response;
      });
    } on SocketException {
      _response = 'Please check your connection.';
    }
    return _response;
  }

  logout() async {
    dynamic _response;
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await http.post(
          Uri(
              scheme: 'https',
              host: ip,
              // if in server , port must be commented
              // port: 8000,
              path: '/api/v1/auth/logout'),
          body: json.encode(body),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'authorization': 'Bearer ' + _sharedPreferences.getString('token')
          }).then((response) {
        _response = response;
      });
    } on SocketException {
      _response = 'Please check your connection.';
    }
    return _response;
  }

  postWithHeader() async {
    dynamic _response;
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await http.post(
          Uri(
              scheme: 'https',
              host: ip,
              // if in server , port must be commented
              // port: 8000,
              path: '/api/v1/$url'),
          body: json.encode(body),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'authorization': 'Bearer ' + _sharedPreferences.getString('token')
          }).then((response) {
        _response = response;
      });
    } on SocketException {
      _response = 'Please check your connection.';
    }
    return _response;
  }

  postNoHeader() async {
    dynamic _response;
    try {
      await http.post(
          Uri(
              scheme: 'https',
              host: ip,
              // port: 8000,
              path: '/api/v1/$url'),
          body: json.encode(body),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }).then((response) {
        _response = response;
      });
    } on SocketException {
      _response = 'Please check your connection.';
    }
    return _response;
  }

  putWithHeader() async {
    dynamic _response;
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await http.put(
          Uri(
              scheme: 'https',
              host: ip,
              // port: 8000,
              path: '/api/v1/$url'),
          body: json.encode(body),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'authorization': 'Bearer ' + _sharedPreferences.getString('token')
          }).then((response) {
        _response = response;
      });
    } on SocketException {
      _response = 'Please check your connection.';
    }
    return _response;
  }

  putNoHeader() async {
    dynamic _response;
    try {
      await http
          .put(
              Uri(
                  scheme: 'https',
                  host: ip,
                  // port: 8000,
                  path: '/api/v1/$url'),
              body: body)
          .then((response) {
        _response = response;
      });
    } on SocketException {
      _response = 'Please check your connection.';
    }
    return _response;
  }

  getWithHeader() async {
    dynamic _response;
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await http.get(
          Uri(
              scheme: 'https',
              host: ip,
              // port: 8000,
              path: '/api/v1/$url'),
          headers: {
            'Accept': 'application/json',
            'authorization': 'Bearer ' + _sharedPreferences.getString('token')
          }).then((response) {
        _response = response;
      });
    } on SocketException {
      _response = 'Please check your connection.';
    }
    return _response;
  }

  getNoHeader() async {
    dynamic _response;
    try {
      await http
          .get(Uri(
              scheme: 'https',
              host: ip,
              // port: 8000,
              path: '/api/v1/$url'))
          .then((response) {
        _response = response;
      });
    } on SocketException {
      _response = 'Please check your connection.';
    }
    return _response;
  }

  // showNoConnection(String text, GlobalKey<ScaffoldMessangerState> key){

  // }

  showLoadingOverlay(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 40 * Config.imageSizeMultiplier,
            width: 20 * Config.imageSizeMultiplier,
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: 10 * Config.imageSizeMultiplier,
                width: 10 * Config.imageSizeMultiplier,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
