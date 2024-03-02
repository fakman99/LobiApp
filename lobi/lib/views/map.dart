import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class MapMain extends StatefulWidget {
  const MapMain({super.key});

  @override
  State<MapMain> createState() => _MapMainState();
}

class _MapMainState extends State<MapMain> {
  @override
  Widget build(BuildContext context) {
  return Stack(
    children:[
      FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(51.509364, -0.128928),
        initialZoom: 9.2,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        
      ],
    ),
      Center(child: Text(" ",style: TextStyle(fontSize: 45),),),
      ] 
  );
}
}

