import 'package:flutter/material.dart';

class OkScreen extends StatefulWidget {
  @override
  _OkScreenState createState() => _OkScreenState();
}

class _OkScreenState extends State<OkScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(),
    );
  }
}
