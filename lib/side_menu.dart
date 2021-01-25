
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final sideMenu;
  SideMenu(this.sideMenu);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Profile'),
              decoration: BoxDecoration(
                color:Colors.yellow,
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: null,
            ),
            ListTile(
              title: Text('Settings'),
              onTap: null,
            )
          ],
        ),
      ),
    );

  }
}
