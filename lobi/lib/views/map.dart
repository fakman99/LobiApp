import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapMain extends StatefulWidget {
  const MapMain({super.key});

  @override
  State<MapMain> createState() => _MapMainState();
}

class _MapMainState extends State<MapMain> {
  late ScrollController scrollController;

  LatLng initialCenter = LatLng(51, 23); // Default initial center

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  double minBound = 0;
  double upperBound = 1.0;
  late LocationPermission permission;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    super.initState();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    print("a");
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: _determinePosition(),
        builder: (context, snapshot) {
          print(snapshot.data?.altitude.toString());
          return Stack(
            children: <Widget>[
              Scaffold(
                  body: Scaffold(
                backgroundColor: Color(0xffecf0f3),
                body: Stack(children: [
                  FlutterMap(
                    options: MapOptions(
                      backgroundColor: Color(0xffecf0f3),
                      initialCenter: LatLng(12, 12),
                      initialZoom: 16,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                    ],
                  ),
                   Padding(
                padding: const EdgeInsets.only(top:82.0),
                child: Container(
                  color: Colors.transparent,
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left:8.0,top: 12),
                        child: Container(
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.sports_soccer_outlined, size: 18,),
                              Text(
                                                      "Football",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.blueGrey),
                                                    ),
                            ],
                          )),
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xffecf0f3),
                            borderRadius: BorderRadius.circular(17),
                       
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, right: 12, left: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffecf0f3),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade500,
                                    offset: Offset(4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1),
                                BoxShadow(
                                    color: Colors.grey.shade500,
                                    offset: Offset(-4, -4),
                                    blurRadius: 15,
                                    spreadRadius: 1)
                              ]),
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                fillColor: Color(0xffecf0f3),
                                filled: true,
                                hintText: 'Rechercher..',
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              )),
              SlidingUpPanelWidget(
                controlHeight: 25.0,
                anchor: 0.4,
                panelController: panelController,
                onTap: () {
                  ///Customize the processing logic
                  if (SlidingUpPanelStatus.expanded == panelController.status) {
                    panelController.collapse();
                  } else {
                    panelController.expand();
                  }
                }, //Pass a onTap callback to customize the processing logic when user click control bar.
                enableOnTap: true, //Enable the onTap callback for control bar.
                dragDown: (details) {
                  print('dragDown');
                },
                dragStart: (details) {
                  print('dragStart');
                },
                dragCancel: () {
                  print('dragCancel');
                },
                dragUpdate: (details) {
                  print(
                      'dragUpdate,${panelController.status == SlidingUpPanelStatus.dragging ? 'dragging' : ''}');
                },
                dragEnd: (details) {
                  print('dragEnd');
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: const Color.fromRGBO(158, 158, 158, 1),
                                  offset: Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 0.5)
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                            color: Color(0xffecf0f3)),
                        alignment: Alignment.center,
                        height: 100.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 60,
                                child: Divider(
                                  thickness: 4,
                                  color: Color.fromARGB(255, 187, 187, 187),
                                )),
                            Text(""),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 90,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(236, 240, 243, 1),
                                        borderRadius: BorderRadius.circular(17),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xffecf0f3),
                                            Color(0xffecf0f3),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(-4, -4),
                                            blurRadius: 15,
                                            spreadRadius: 1,
                                          ),
                                          BoxShadow(
                                            color: Color(0xffd1d5d8),
                                            offset: Offset(4, 4),
                                            blurRadius: 15,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.orange,
                                              size: 18,
                                            ),
                                            Text(
                                              "Lobi",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      print('object');
                                    },
                                    child: Container(
                                      width: 90,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(236, 240, 243, 1),
                                        borderRadius: BorderRadius.circular(17),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xffecf0f3),
                                            Color(0xffecf0f3),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(-4, -4),
                                            blurRadius: 15,
                                            spreadRadius: 1,
                                          ),
                                          BoxShadow(
                                            color: Color(0xffd1d5d8),
                                            offset: Offset(4, 4),
                                            blurRadius: 15,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: Colors.orange,
                                            size: 18,
                                          ),
                                          Text(
                                            "Place",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0.5,
                        color: const Color.fromRGBO(224, 224, 224, 1),
                      ),
                      Flexible(
                        child: Container(
                          child: ListView.builder(
                            controller: scrollController,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 80,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Icon(Icons.sports_soccer),
                                          ),
                                          Container(
                                            width: 180,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Partie de Squatch 4 pers.",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12,
                                                        color: Colors.black)),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Public   ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Colors.green),
                                                    ),
                                                    Text(
                                                      "*  5/10",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.blueGrey),
                                                    ),
                                                    Icon(
                                                      Icons.person_2_outlined,
                                                      size: 12,
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  "Sq. De Fré 1, 1180 Ucclezqdqzdqdz",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.blueGrey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons
                                                  .favorite_border_outlined)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.login))
                                        ],
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(236, 240, 243, 1),
                                    borderRadius: BorderRadius.circular(17),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xffecf0f3),
                                        Color(0xffecf0f3),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xffd1d5d8),
                                        offset: Offset(-4, -4),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                      BoxShadow(
                                        color: Color(0xffd1d5d8),
                                        offset: Offset(4, 4),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: 20,
                          ),
                          color: Color(0xffecf0f3),
                        ),
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  color: Color(0xffecf0f3),
                ),
              ),
             
            ],
          );
        },
      ),
    );
  }
}
