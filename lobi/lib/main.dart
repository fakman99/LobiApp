import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lobby/Model/AppModel.dart';
import 'package:lobby/pages/MainPage.dart';
import 'package:lobby/views/onBoarding.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) {
      return AppModel();
    },
    child: const MyApp(),
  ));
}

Future<bool?> getNeedOfOnboarding() async {
  final storage = FlutterSecureStorage();
  bool? needOnboarding = await storage.containsKey(key: 'needOnboarding');
  return needOnboarding;
}

Future<String?> getAccessToken() async {
  final storage = FlutterSecureStorage();
  String? accessToken = await storage.read(key: 'accessToken');
  return accessToken;
}

Future<Map<String, String>> getAllStorageInfo() async {
  final storage = FlutterSecureStorage();
  Map<String, String> storageInfo = await storage.readAll();
  return storageInfo;
}

//ADD THE LOGIC FOR ONBOARDING SCREEN / LOGIN PAGE / OR CONNECTED
StatefulWidget checkConnectionStatus() {
  StatefulWidget firstScreenToShow = LoginPage();
  String? accessToken = '';
  bool? needOnboarding;

  getNeedOfOnboarding().then((bool? value) {
    needOnboarding = value;
  });
  //First time opening app
  if (needOnboarding == true) {
    firstScreenToShow = Onboarding();
  } else {
    //get access token  to check if connected
    getAccessToken().then((String? value) {
      accessToken = value;
    });
    //Cas ou access token deja existant en local
    if (accessToken != null) {
      firstScreenToShow = Home();
    }
  }
  getAllStorageInfo().then((Map<String, String> value){
    for (var element in value.values) {
      print(element);
    }
  });
  return firstScreenToShow;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return checkConnectionStatus();
        },
      ),
    );
  }
}
