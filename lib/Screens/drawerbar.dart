import 'package:contactapp/Screens/addcontacts.dart';
import 'package:contactapp/Screens/categorypage.dart';
import 'package:contactapp/Screens/contactlist.dart';
import 'package:contactapp/color/color.dart';
import 'package:flutter/material.dart';

class DrawerBar extends StatefulWidget {
  const DrawerBar({super.key});

  @override
  State<DrawerBar> createState() => _DrawerBarState();
}

class _DrawerBarState extends State<DrawerBar> {
  int _counter=0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const List<Widget> _screens=<Widget>[
    CategoryPage(),
    AddContact(),
    ContactList()
  ];
  @override
  Widget build(BuildContext context) {
    List<String> drawerData=["Add Category", "Add Contact","Contact List","","","","","","","","","","","","","","","","","","","","",""];
    return Scaffold(
      key: _scaffoldKey,
      body: _screens[_counter],
        drawer: Drawer(
          backgroundColor: drawerBgColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0),
                bottomRight: Radius.circular(0),
          ),),
          child:
          ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children:[
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        setState(() {
                          _counter=index;
                        });
                      },
                      child: Padding(padding: EdgeInsets.all(20),
                        child: Text(
                          "${drawerData[index]}",
                          style: TextStyle(color: Colors.white),
                       ),),
                    ),
                    Divider(
                      color: drawerBgLine, // Customize the color of the divider
                       thickness: 1, // Customize the thickness of the divider
                    )
                  ]
                );
              },
          ),
        ),
    );
  }
}
