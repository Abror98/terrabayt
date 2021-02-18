import 'package:flutter/material.dart';
import 'package:terrabayt/consts/consts.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/image/tera_full_logo.png"),
              ),
            ),
            Divider(
              color: Colors.black26,
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black26,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(drawer_list[index], style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
