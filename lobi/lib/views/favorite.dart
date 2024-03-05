import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}
enum Menu { supprimer, partager }

class _FavoriteState extends State<Favorite> {

    @override
  initState() {
    super.initState();
    
      
    
  }




  String _selectedMenu = '';

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Enregistrés',
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: Color.fromARGB(255, 0, 0, 0),
            )),
        elevation: 0,
        backgroundColor: Colors.grey[200],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 12, bottom: 12),
            child: Text(
              "Enregistrés récemment",
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              top: 12,
              right: 12,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vos listes",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.add,
                            color: Color.fromARGB(255, 0, 160, 253)),
                        Text(
                          "Nouvelle liste",
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 160, 253),
                          ),
                        )
                      ])
                ]),
          ),
          Column(
            children: [
              GestureDetector(
                child: ListTile(
                  onTap: () {
                    
                  },
                  leading: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.red,
                  ),
                  title: Text("Favoris",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  subtitle: Text("4 lobis",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                      )),
                  trailing: PopupMenuButton<Menu>(
                      icon: Icon(Icons.more_horiz),
                      // Callback that sets the selected popup menu item.
                      onSelected: (Menu item) {
                        setState(() {
                          _selectedMenu = item.name;
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<Menu>>[
                            const PopupMenuItem<Menu>(
                              value: Menu.supprimer,
                              child: Text('Supprimer'),
                            ),
                            const PopupMenuItem<Menu>(
                              value: Menu.partager,
                              child: Text('Partager'),
                            ),
                          ]),
                ),
              ),
              ListTile(
                onTap: () {
                  
                },
                leading: Icon(
                  Icons.schedule_outlined,
                  color: Colors.green,
                ),
                title: Text("A venir",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
                subtitle: Text("a" + " lobis",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                    )),
                trailing: PopupMenuButton<Menu>(
                    icon: Icon(Icons.more_horiz),
                    // Callback that sets the selected popup menu item.
                    onSelected: (Menu item) {
                      setState(() {
                        _selectedMenu = item.name;
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Menu>>[
                          const PopupMenuItem<Menu>(
                            value: Menu.supprimer,
                            child: Text('Item 1'),
                          ),
                          const PopupMenuItem<Menu>(
                            value: Menu.partager,
                            child: Text('Item 2'),
                          ),
                        ]),
              ),
              ListTile(
                onTap: () {
                  
                },
                leading: Icon(Icons.star_outline_outlined,
                    color: Colors.orangeAccent),
                title: Text("Lieus enregistrées",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
                subtitle: Text("0 lieu",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                    )),
                trailing: PopupMenuButton<Menu>(
                    icon: Icon(Icons.more_horiz),
                    // Callback that sets the selected popup menu item.
                    onSelected: (Menu item) {
                      setState(() {
                        _selectedMenu = item.name;
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Menu>>[
                          const PopupMenuItem<Menu>(
                            value: Menu.supprimer,
                            child: Text('Item 1'),
                          ),
                          const PopupMenuItem<Menu>(
                            value: Menu.partager,
                            child: Text('Item 2'),
                          ),
                        ]),
              ),
            ],
          ),
                 Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              top: 12,
              right: 12,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Votre historique",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                   
                    },
                    child: Text(
                      "Afficher plus",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 160, 253),
                      ),
                    ),
                  )
                ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top:12.0),
              child: Center(
                child:  Center(child:  GestureDetector(
                  child: ListTile(
                    onTap: () {
                     
                    },
                    leading: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.red,
                    ),
                    title: Text('efds',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    subtitle: Text("12/01/2023".toString(),
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                        )),
                    trailing: PopupMenuButton<Menu>(
                        icon: Icon(Icons.more_horiz),
                        // Callback that sets the selected popup menu item.
                        onSelected: (Menu item) {
                          setState(() {
                            _selectedMenu = item.name;
                          });
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<Menu>>[
                              const PopupMenuItem<Menu>(
                                value: Menu.supprimer,
                                child: Text('Supprimer'),
                              ),
                              const PopupMenuItem<Menu>(
                                value: Menu.partager,
                                child: Text('Partager'),
                              ),
                            ]),
                  ),
                ),)
              ),
            ),
          ),
        ],
      ),
    );
  }
}