import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class DetailScreen extends StatelessWidget{
  String title;
  String content;
  String image;


  DetailScreen(this.title, this.image, this.content);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: true,
                  pinned: true,
                  snap: true,
                  actionsIconTheme: IconThemeData(opacity: 0.0),
                  flexibleSpace: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                          ))
                    ],
                  ),
                ),

              ];
            },
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 24)),
              Html(data: content),
            ],
          ),
        ),
      ),
        ));
  }
}

// SingleChildScrollView(
//   child: Column(
//     children: [
//       Text(title),
//       Image.network(image),
//       Html(
//           data: content),
//     ],
//   ),
// ),

