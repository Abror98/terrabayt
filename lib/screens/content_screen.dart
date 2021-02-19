import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:terrabayt/model/info_model.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ContentScreen extends StatefulWidget {
  static MaterialPageRoute route({NewsModel postModel}) =>
  MaterialPageRoute(builder: (_) => screen(postModel: postModel));

  static Widget screen({NewsModel postModel}) => ContentScreen(postModel);

  final NewsModel postModel;

  const ContentScreen(this.postModel);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  WebViewController controller;
  double webViewHeight = 1;

  String title = '';
  String excerpt = '';
  String categoryName = '';
  String postModified = '';
  String image = '';
  String content = '';

  @override
  void initState() {
    final NewsModel postModel = widget.postModel;
    title = postModel.title;
    excerpt = postModel.excerpt;
    categoryName = postModel.categoryName;
    postModified = postModel.postModified;
    image = postModel.image;
    content = postModel.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            child: Text('$postModified'),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(imageUrl: image),
            SizedBox(
              height: webViewHeight,
              child: WebView(
                initialUrl: 'https://flutter.io',
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (url) => onPageFinished(),
                onWebViewCreated: (controller) async {
                  this.controller = controller;
                  loadString();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadString() async {
    controller.loadUrl(Uri.dataFromString(
      content.replaceAll("<span>{tap_to_load}</span>", "").replaceAll(
          "<div class='imgbox'><img data-src=",
          "<div class='imgbox'><img width=100% src="),
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString());
  }

  Future<void> onPageFinished() async {
    try {
      webViewHeight = double.parse(await controller
          .evaluateJavascript("document.documentElement.scrollHeight;"));
      setState(() {});
    } catch (_) {}
  }
}