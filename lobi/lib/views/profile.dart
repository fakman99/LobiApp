import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lobby/Model/AppModel.dart';
import 'package:provider/provider.dart';






class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context,value,child){
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: Text(value.srcKey)
        )
    );
    });
  }
}


