import 'package:flutter/material.dart';
import './ui/pages/home.dart';
import 'package:marquee_widget/marquee_widget.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Adda General Knowledge',

      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.lightBlue,
          fontFamily: "Montserrat",
          buttonColor: Colors.indigo,
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              textTheme: ButtonTextTheme.primary
          )
      ),
      home: HomePage()

    );
  }
}