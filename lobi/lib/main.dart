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

deleteAllShared() async {
  final storage = FlutterSecureStorage();
  await storage.deleteAll();
}

Future<bool> getNeedOfOnboarding() async {
  final storage = FlutterSecureStorage();
  bool needOnboarding = await storage.containsKey(key: 'needOnboarding');
  return needOnboarding;
}

Future<List<Object?>> checkConnectionStatus() async {
  final storage = FlutterSecureStorage();
  String? accessToken = await storage.read(key: 'accessToken');
  bool needOnboarding = await storage.containsKey(key: 'needOnboarding');
  List res = [];
  res.add(accessToken);
  res.add(needOnboarding);
  return res ;
}

Future<Map<String, String>> getAllStorageInfo() async {
  final storage = FlutterSecureStorage();
  Map<String, String> storageInfo = await storage.readAll();
  return storageInfo;
}

//ADD THE LOGIC FOR ONBOARDING SCREEN / LOGIN PAGE / OR CONNECTED
StatefulWidget viewSwitcher(List<Object?>? connectionStatus) {
  //deleteAllShared(); debuging purpose
  getAllStorageInfo().then((Map<String, String> value){
    for (var element in value.values) {
      print(element);
    }
  });
    StatefulWidget firstScreenToShow = LoginPage();

  switch (connectionStatus!.elementAt(1)) {
    case true:
      break;
    default:
      return firstScreenToShow = Onboarding();
  }
  switch (connectionStatus!.elementAt(0)) {
    case null:
      return firstScreenToShow = LoginPage();
    default:
      return firstScreenToShow = Home();
  }
  
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: checkConnectionStatus(),
        builder: (context,snapshot) {
          return viewSwitcher(snapshot.data);
        },
      ),
    );
  }
}
