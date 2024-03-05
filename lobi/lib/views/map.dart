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

Future<Position> getPosition() async {
  var a = await Geolocator.getCurrentPosition();
  print(a.latitude.toDouble().toString());
  return a;
}

class _MapMainState extends State<MapMain> {
  late ScrollController scrollController;

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  final _SearchTextController = TextEditingController(text: "Search");
  double minBound = 0;

  double upperBound = 1.0;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Scaffold(
              body: FutureBuilder(
            future: getPosition(),
            builder: (context, snapshot) {
              return Scaffold(
                body: Stack(children: [
                  FlutterMap(
                    
                    options: MapOptions(
                      backgroundColor: const Color.fromRGBO(158, 158, 158, 1),
                      initialCenter: LatLng(50.85045, 4.34878),
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
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 12.0, right: 12, left: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(238, 238, 238, 1),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade500,
                                    offset: Offset(4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1),
                                BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-4, -4),
                                    blurRadius: 15,
                                    spreadRadius: 1)
                              ]),
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                fillColor: const Color.fromRGBO(238, 238, 238, 1),
                                filled: true,
                                hintText: 'Rechercher..',
                              
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
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
              );
            },
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
                        color: const Color.fromRGBO(238, 238, 238, 1)),
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
                        Row(
                          children: <Widget>[],
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
                      child: ListView.separated(
                        controller: scrollController,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('list item $index'),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 0.5,
                          );
                        },
                        shrinkWrap: true,
                        itemCount: 20,
                      ),
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
