import 'package:flutter/material.dart';
import 'package:lobby/Model/AppModel.dart';
import 'package:lobby/pages/MainPage.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        return AppModel();
      },
      child:  const MyApp(),
    )
    
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    StatefulWidget firstScreenToShow = LoginPage();
    //ADD THE LOGIC FOR ONBOARDING SCREEN / LOGIN PAGE / OR CONNECTED
    if("test"=="test"){
      firstScreenToShow = Home();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: firstScreenToShow,
    );
  }
}
