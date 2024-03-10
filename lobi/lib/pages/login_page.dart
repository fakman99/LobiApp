import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lobby/Model/AppModel.dart';
import 'package:lobby/components/my_button.dart';
import 'dart:convert';

import 'package:lobby/components/my_textfield.dart';
import 'package:lobby/components/square_tile.dart';
import 'package:lobby/pages/MainPage.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  Future<List> signIn() async {
    final reponse = await http
        .post(Uri.parse('http://89.116.229.190:3000/api/auth/signin'), body: {
      "username": usernameController.text,
      "password": passwordController.text,
    });
    return [reponse.statusCode,reponse.body];
  }

  void saveAccessToken(String accessToken) async {
  final storage = FlutterSecureStorage();
  await storage.write(key: 'accessToken', value: accessToken);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecf0f3),
      body: Consumer<AppModel>(
        builder: (context,build,child){
          return SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
        
                  // logo
                  // const Icon(
                  //   Icons.lock,
                  //   size: 100,
                  // ),
        
                  const SizedBox(height: 50),
        
                  // welcome back, you've been missed!
                  Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
        
                  const SizedBox(height: 25),
        
                  // username textfield
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
        
                  const SizedBox(height: 10),
        
                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
        
                  const SizedBox(height: 10),
        
                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
        
                  const SizedBox(height: 25),
        
                  // sign in button
                  MyButton(
                    onTap: () async {
                      signIn().then((List value) {
                        final body = json.decode(value[1]);
                        switch (value[0]) {
                          case 200:
                            saveAccessToken(body["accessToken"]);
                            Provider.of<AppModel>(context,listen: false).setKey(body["accessToken"]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  Home()),
                            );
                            break;
                          case 404:
                            print("WRONG USER");
        
                            break;
                          case 401:
                            print("WRONG PASSWORD");
        
                            break;
                          case 200:
                            break;
                          default:
                        }
                      });
                    },
                  ),
        
                  const SizedBox(height: 50),
        
                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
        
                  const SizedBox(height: 50),
        
                  // google + apple sign in buttons
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button
                      SquareTile(imagePath: 'lib/images/google.png'),
        
                      SizedBox(width: 25),
        
                      // apple button
                      SquareTile(imagePath: 'lib/images/apple.png')
                    ],
                  ),
        
                  const SizedBox(height: 50),
        
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
        },
     
      ),
    );
  }
}
