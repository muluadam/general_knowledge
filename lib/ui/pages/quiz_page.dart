import 'package:flutter/material.dart';
import 'package:generalknowledge/admob/MyAdUnits.dart';
import 'package:generalknowledge/models/category.dart';
import 'package:generalknowledge/models/question.dart';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:generalknowledge/ui/pages/quiz_finished.dart';
 import 'package:html_unescape/html_unescape.dart';
import 'package:firebase_admob/firebase_admob.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  final Category category;

  const QuizPage({Key key, @required this.questions, this.category}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextStyle _questionStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.white
  );

  int _currentIndex = 0;
  final Map<int,dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  BannerAd myBanner;
  BannerAd buildBannerAd() {

    return BannerAd(
      //  adUnitId: 'ca-app-pub-3940256099942544/6300978111', //testing
        adUnitId:MyAdUnits.Adunit,  //orginal ca-app-pub-1338918288651248/3171919369
        size: AdSize.smartBanner,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            myBanner..show();
          }
        }
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myBanner.dispose();
  }

  @override
  Widget build(BuildContext context){
    FirebaseAdMob.instance.initialize(appId: MyAdUnits.AppID);

    myBanner= buildBannerAd()..load()..show();

    Question question = widget.questions[_currentIndex];
    final List<dynamic> options = question.incorrectAnswers;
    if(!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.shuffle();
    }
    
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _key,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height:AdSize.smartBanner.height.toDouble() ,
            width: AdSize.smartBanner.width.toDouble(),


          ),
          color: Colors.red,
        ),

        appBar: AppBar(

          title: Text(widget.category.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          ),
          elevation: 3,
        ),
        body: Stack(
          children: <Widget>[
            ClipRect(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor
                ),
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text("${_currentIndex+1}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:FontWeight.bold,
                          fontSize: 20.0,

                        ),),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(HtmlUnescape().convert(widget.questions[_currentIndex].question),
                          softWrap: true,
                          style: _questionStyle,),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.0),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ...options.map((option)=>RadioListTile(
                          title: Text(HtmlUnescape().convert("$option")),
                          groupValue: _answers[_currentIndex],
                          value: option,
                          onChanged: (value){
                            setState(() {
                              _answers[_currentIndex] = option;
                            });
                          },
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding:EdgeInsets.fromLTRB(0, 0, 0, 100),
                      child: RaisedButton(
                        child: Text( _currentIndex == (widget.questions.length - 1) ? "Submit" : "Next"),
                        onPressed: _nextSubmit,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _nextSubmit() {
    if(_answers[_currentIndex] == null) {
      _key.currentState.showSnackBar(SnackBar(
        content: Text("You must select an answer to continue."),
      ));
      return;
    }
    if(_currentIndex < (widget.questions.length - 1)){
      setState(() {
          _currentIndex++;
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => QuizFinishedPage(questions: widget.questions, answers: _answers)
      ));
    }
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Text("Are you sure you want to quit the quiz? All your progress will be lost."),
          title: Text("Warning!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: (){
                Navigator.pop(context,true);
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: (){
                Navigator.pop(context,false);
              },
            ),
          ],
        );
      }
    );
  }
}