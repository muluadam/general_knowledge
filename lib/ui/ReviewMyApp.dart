import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';



class ReviewMyApp extends StatefulWidget {
  @override
  _ReviewMyAppState createState() => new _ReviewMyAppState();
}

class _ReviewMyAppState extends State<ReviewMyApp> {
  @override
  void initState() {
    super.initState();
    AppReview.getAppID.then((String onValue) {
      setState(() {
        appID = onValue;
      });
      print("App ID" + appID);
    });
    AppReview.storeListing.then((String onValue) {
      setState(() {
        output = onValue;
      });
      print(onValue);
    });

  }

  String appID = "";
  String output = "";

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(title: const Text('App Review')),
        body: new Container(


        ),
      ),
    );
  }
}