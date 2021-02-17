import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BottomLoading extends StatelessWidget {
  final bool visible;

  const BottomLoading({this.visible});

  @override
  Widget build(BuildContext context) {
    if(visible)
    return Container(
      height: 40,
      width: double.infinity,
      alignment: Alignment.center,
      child: SpinKitFadingCircle(color: Colors.grey),
    );
    return SizedBox();
  }
}
