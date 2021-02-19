import 'package:flutter/material.dart';
import 'package:terrabayt/consts/consts.dart';
import 'package:terrabayt/screens/base_screen.dart';
import 'package:terrabayt/screens/okscreeen.dart';
import 'package:terrabayt/widgets/drawer.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  final drawerItems = [
    DrawerItem(drawer_list[0]),
 //   DrawerItem(drawer_list[1]),
    DrawerItem(drawer_list[2]),
    DrawerItem(drawer_list[3]),
    DrawerItem(drawer_list[4]),
    DrawerItem(drawer_list[5]),
  ];

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return  BaseScreen.screen(0);
        break;
      case 1:
        return BaseScreen.screen(482);
        break;
      case 2:
        return BaseScreen.screen(35);
      case 3:
        return BaseScreen.screen(1205);
      case 4:
        return BaseScreen.screen(97);
      default: OkScreen();
    }
  }

  _onSelectItem(int index) async {
    _selectedDrawerIndex = -1;
    setState((){
    });
    await Future.delayed(Duration(milliseconds: 500));
    _selectedDrawerIndex = index;
    setState(() {
          });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          Column(
            children: [
              ListTile(
                title: new Text(d.title, style: TextStyle(color: Colors.white),),
                selected: i == _selectedDrawerIndex,
                onTap: () => _onSelectItem(i),
              ),
              Divider(color: Colors.black26),
            ],
          )
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Terabayt")),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
        drawer: Drawer(
          child: Container(
            color: Colors.blue,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/image/tera_full_logo.png"),
                    )),
                Divider(color: Colors.black26),
                Column(children: drawerOptions)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


