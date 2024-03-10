import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lobby/views/add.dart';
import 'package:lobby/views/favorite.dart';
import 'package:lobby/views/map.dart';
import 'package:lobby/views/profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    var anim = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 500),
    );
    return Scaffold(
      backgroundColor: Color(0xffecf0f3),
      extendBody: true,
      body: Expanded(child: () {
        if (_selectedTab.index == 1) {
          return Favorite();
        }
        if (_selectedTab.index == 2) {
          return Add();
        }
        if (_selectedTab.index == 0) {
          return MapMain();
        }
        return Profile();
      }()),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: DotNavigationBar(
          backgroundColor: Color(0xffecf0f3),
          marginR: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          paddingR: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          onTap: _handleIndexChanged,
          dotIndicatorColor: Colors.black,
          items: [
            DotNavigationBarItem(
              icon: Icon(Icons.place_outlined),
              selectedColor: Colors.teal,
            ),

            /// Likes
            DotNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              selectedColor: Colors.pink,
            ),

            /// Search
            DotNavigationBarItem(
              icon: Icon(Icons.data_saver_on),
              selectedColor: Colors.orange,
            ),

            /// Profile
            DotNavigationBarItem(
              icon: Icon(Icons.person),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}

enum _SelectedTab { home, favorite, search, person }
