import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import 'detail_creen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: MyHomePage(),
    );
  }
}



class MyHomePage  extends StatefulWidget{

  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = new TextEditingController();

  Future<Null> getUserDetails() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
           title: const Text('Tech news'),
         backgroundColor: Theme.of(context).primaryColor,
         actions: [

         ],
       ),
       body: new Column(
         children: <Widget>[
           new Container(
             color: Theme.of(context).primaryColor,
             child: new Padding(
               padding: const EdgeInsets.all(8.0),
               child: new Card(
                 child: new ListTile(
                   leading: new Icon(Icons.search),
                   title: new TextField(
                     controller: controller,
                     decoration: new InputDecoration(
                         hintText: 'Search', border: InputBorder.none),
                     onChanged: onSearchTextChanged,
                   ),
                   trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                     controller.clear();
                     onSearchTextChanged('');
                   },),
                 ),
               ),
             ),
           ),
           new Expanded(
             child: _searchResult.length != 0 || controller.text.isNotEmpty
                 ? new ListView.builder(
               itemCount: _searchResult.length,
               itemBuilder: (context, i) {
                 return GestureDetector(
                   onTap: (){
                     Scaffold
                         .of(context)
                         .showSnackBar(SnackBar(content: Text("index")));
                   },

                   child: new Card(
                     child: new ListTile(
                       leading: new ConstrainedBox(
                         constraints: BoxConstraints(
                           minWidth: 150,
                           minHeight: 150,
                         ),
                         child: Image.network(_searchResult[i].image, fit: BoxFit.cover,),),
                       title: new Text(_searchResult[i].title),
       //              subtitle: new Text( _searchResult[i].content),
                     ),
                     margin: const EdgeInsets.all(0.0),
                   ),
                 );
               },
             )
                 : new ListView.builder(
               itemCount: _userDetails.length,
               itemBuilder: (context, index) {
                 return GestureDetector(
                   onTap: (){
                     Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => DetailScreen(_userDetails[index].title, _userDetails[index].image, _userDetails[index].content),
                         ));
                   },
                   child: new Card(
                     child: new ListTile(
                       leading: new ConstrainedBox(constraints: BoxConstraints(
                        minHeight: 150,
                        minWidth: 150,
                       ),
                 child: CachedNetworkImage(
                 imageUrl: _userDetails[index].image,
                 imageBuilder: (context, imageProvider) => Container(
                 decoration: BoxDecoration(
                 image: DecorationImage(
                 image: imageProvider,
                 fit: BoxFit.cover,
                 colorFilter:
                 ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                 ),
                 ),
                 placeholder: (context, url) => CircularProgressIndicator(),
                 errorWidget: (context, url, error) => Icon(Icons.error),
                 ),),
                       title: new Text(_userDetails[index].title),
          //           subtitle: new Text( _searchResult[i].content),
                     ),
                     margin: const EdgeInsets.all(0.0),
                   ),
                 );
               },
             ),
           ),
         ],
       ),
     );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {
        return;
      });

    }



    setState(() {
      _userDetails.forEach((userDetail) {
        String lowerText =  userDetail.title.toLowerCase();
        String textLowerase = text.toLowerCase();
        if (lowerText.contains(textLowerase))
          _searchResult.add(userDetail);
      });
    });
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

final String url = 'https://www.terabayt.uz/api.php?action=posts';
class UserDetails {
  final int id;
  final String title, content, image;

  UserDetails({this.id, this.title, this.content, this.image});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
    );
  }
}