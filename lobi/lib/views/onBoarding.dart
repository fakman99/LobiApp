import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}
 void onBoardingMade() async {
  final storage = FlutterSecureStorage();
  await storage.write(key: 'needOnboarding', value: '1');
  print("hey");
}
class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.purple,body: Center(child: IconButton(onPressed: onBoardingMade, icon: Icon(Icons.abc)),),

    );
  }
}