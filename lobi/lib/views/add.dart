import 'dart:async';
import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';



class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  bool _isOpen2 = false;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  late AnimationController _animationController;
  late AnimationController _animationController2;
  late double lat;
  late double long;
  MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<OSMdata> _options = <OSMdata>[];
  Timer? _debounce;

  void setNameCurrentPos() async {
    var client = http.Client();
    double latitude = _mapController.center.latitude;
    double longitude = _mapController.center.longitude;
    if (kDebugMode) {
      print(latitude);
    }
    if (kDebugMode) {
      print(longitude);
    }
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    setState(() {});
  }

  void setNameCurrentPosAtInit() async {
    var client = http.Client();
    double latitude = lat;
    double longitude = long;
    if (kDebugMode) {
      print(latitude);
    }
    if (kDebugMode) {
      print(longitude);
    }
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

    _searchController.text =
        decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
    setState(() {});
  }

  

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<Position> getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  MapController mapController = MapController();
  var textlat = TextEditingController();
  var textlong = TextEditingController();

  final _formKeyName = GlobalKey<FormBuilderState>();
  var textName = TextEditingController();
  final _formKeyGsm = GlobalKey<FormBuilderState>();
  var textGsm = TextEditingController();
  final _formKeyDesc = GlobalKey<FormBuilderState>();
  var textDesc = TextEditingController();
  final _formKeyAdress = GlobalKey<FormBuilderState>();
  var textAdress = TextEditingController();
  var _searchGeoController = TextEditingController();
  final _formKeyGeo= GlobalKey<FormBuilderState>();

  final _formKeyDate = GlobalKey<FormBuilderState>();
  var textDate = TextEditingController();
  var date;
  List<String> sportOptions = ['Basketball', 'Football', 'Tennis'];

  final _formKeySport = GlobalKey<FormBuilderState>();
  var textSport = TextEditingController();

  final _formKeyNbrJ = GlobalKey<FormBuilderState>();
  var textNbrJ = TextEditingController(text: "5");
  @override
  Widget build(BuildContext context) {
    double widths = MediaQuery.of(context).size.width;
    List<OSMdata> _options = <OSMdata>[];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                
                
              },
              icon: Icon(
                Icons.close,
                color: Colors.black,
              )),
          centerTitle: true,
          title: Text(
            'Ajouter  un rdv',
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        //Init Floating Action Bubble
   
        body: ListView(children: [
          Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 12, bottom: 12, right: 15),
                    child: Text(
                      "Information du lobi",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Text(
                      "Donnez des infos sur ce rdv. S'il est ajouté à Lobi, il sera visible publiquement.",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Color.fromARGB(255, 139, 139, 139),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 12, left: 15, right: 15),
                child: FormBuilder(
                  key: _formKeyName,
                  child: FormBuilderTextField(
                    decoration: InputDecoration(
                      hintText: 'Ajouter le nom du lobi',
                      labelText: 'Nom du lobi (obligatoire)*',
                      floatingLabelStyle: TextStyle(color: Colors.orange),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusColor: Colors.orange,
                    ),
                    controller: textName,
                    name: 'name',
                    onChanged: (val) {
                      print(val); // Print the text value write into TextField
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 12, left: 15, right: 15),
                child: FormBuilderDropdown<String>(
                  onChanged: (value) {
                    textSport = TextEditingController(text: value);
                  },
                  name: 'sport',
                  decoration: InputDecoration(
                    enabled: false,
                    hintText: 'Selectionner un sport',
                    floatingLabelStyle: TextStyle(color: Colors.orange),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusColor: Colors.orange,
                  ),
                  items: sportOptions
                      .map((gender) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                ),
              ),
              ExpansionPanelList(
                animationDuration: Duration(milliseconds: 1000),
                dividerColor: Colors.red,
                elevation: 1,
                children: [
                  ExpansionPanel(
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:5,
                               bottom: 12, left: 15, right: 15),
                          child: FormBuilder(
                            key: _formKeyDesc,
                            child: FormBuilderTextField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.description),
                                enabled: true,
                                hintText: 'Description',
                                labelText: 'Description',
                                floatingLabelStyle:
                                    TextStyle(color: Colors.orange),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusColor: Colors.orange,
                              ),
                              controller: textDesc,
                              name: 'text',
                              onChanged: (val) {
                                print(
                                    val); // Print the text value write into TextField
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 15, left: 15, right: 15),
                          child: FormBuilder(
                            key: _formKeyDate,
                            child: FormBuilderDateTimePicker(
                              decoration: InputDecoration(
                                enabled: false,
                                icon: Icon(Icons.calendar_month),
                                hintText: 'Date',
                                labelText: 'Date',
                                floatingLabelStyle:
                                    TextStyle(color: Colors.orange),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusColor: Colors.orange,
                              ),
                              controller: textDate,
                              fieldLabelText: 'Date',
                              name: 'text',
                              onChanged: (val) {
                                date = val;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 20, left: 15, right: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: FormBuilderTextField(
                              controller: textNbrJ,
                              name: 'nbr',
                              decoration: InputDecoration(
                                icon: Icon(Icons.group),
                                enabled: false,
                                hintText: 'Nombre de joueur',
                                labelText: 'Nombre de joueur',
                                floatingLabelStyle:
                                    TextStyle(color: Colors.orange),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusColor: Colors.orange,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 12, bottom: 12, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Ajouter des informations",
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Ajoutez des informations supplémentaires afin de mieux décrire l'activité dans son ensemble.",
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 139, 139, 139),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    isExpanded: _isOpen,
                  )
                ],
                expansionCallback: (int item, bool status) {
                  setState(() {
                    _isOpen = !_isOpen;
                  });
                },
              ),
              ExpansionPanelList(
                animationDuration: Duration(milliseconds: 1000),
                dividerColor: Colors.red,
                elevation: 1,
                children: [
                  ExpansionPanel(
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, bottom: 15, left: 12, right: 12),
                          child: FormBuilder(
                            key: _formKeyGsm,
                            child: FormBuilderTextField(
                                                            keyboardType: TextInputType.number,

                              decoration: InputDecoration(
                                enabled: false,
                                hintText: 'Téléphone / GSM',
                                labelText: 'Téléphone / GSM',
                                floatingLabelStyle:
                                    TextStyle(color: Colors.orange),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusColor: Colors.orange,
                              ),
                              controller: textGsm,
                              name: 'text',
                              onChanged: (val) {
                                print(
                                    val); // Print the text value write into TextField
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, bottom: 5, left: 15, right: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width  ,
                            child: FormBuilder(
                              enabled: false,
                              key: _formKeyAdress,
                              child: FormBuilderTextField(
                                maxLines: 3,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Adresse :',
                                ),
                                controller: _searchController,
                                name: 'text',
                                onChanged: (val) {},
                              ),
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, bottom: 5, left: 15, right: 15),
                          child: Container(
                                                        width: MediaQuery.of(context).size.width  ,

                            child: FormBuilder(
                              enabled: false,
                              key: _formKeyGeo,
                              child: FormBuilderTextField(
                                                              maxLines:2,

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Coordonnées géograpique :',
                                ),
                                controller: _searchGeoController,
                                name: 'text',
                                onChanged: (val) {},
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        child: Container())))),
                      ],
                    ),
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          top: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Contact",
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, bottom: 12),
                              child: Text(
                                "Ajoutez un numéro de téléphone, des horaires, et d'autres informations supplémentaires.",
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 139, 139, 139),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    isExpanded: _isOpen2,
                  )
                ],
                expansionCallback: (int item, bool status) {
                  setState(() {
                    _isOpen2 = !_isOpen2;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 18),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //OutlinedBorder()
                      Container(
                        width: MediaQuery.of(context).size.width/3,
                        child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.grey, width: 1))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Annuler",
                              style: TextStyle(color: Colors.orange),
                            )),
                      ),
                      Container(
                                                width: MediaQuery.of(context).size.width/3,

                        child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.orange, width: 2))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.orange),
                            ),
                            onPressed: () {
                              
                            },
                            child: Text(
                              "Ajouter",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
        ]));
  }
}
