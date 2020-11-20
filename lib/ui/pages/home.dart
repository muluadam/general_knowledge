import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:generalknowledge/models/category.dart';
import 'package:generalknowledge/ui/ReviewMyApp.dart';
import 'package:generalknowledge/ui/widgets/quiz_options.dart';
import 'package:generalknowledge/util/RateThisApp.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  final List<Color> tileColors = [
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.indigo,
    Colors.lightBlue,
    Colors.amber,
    Colors.deepOrange,
    Colors.red,
    Colors.brown
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: AdSize.smartBanner.height.toDouble(),
            width: AdSize.smartBanner.width.toDouble(),

            //  child: Text('ADd '),
          ),
          color: Colors.red,
        ),
        appBar: AppBar(
          title: Text('General Knowledge Quiz app'),
          elevation: 0,
          actions: <Widget>[
            new RaisedButton(
                color: Colors.red,
                child: new Text("Rate This App"),
                onPressed: () {
//                  Navigator.of(context)
//                      .push(MaterialPageRoute(builder: (_) => ReviewMyApp()));

                 RateThisApp.openRatingPage();


                }),
//            new RaisedButton(
//                color: Colors.lightBlue,
//                child: new Text(
//                  "install123",
//                  style: TextStyle(color: Colors.white),
//                ),
//                onPressed: () {
//                  StoreRedirect.redirect(
//                      androidAppId: "com.instantsystems.itender",
//                      iOSAppId: "585027354");
//                })
          ],
        ),
        body: Stack(
          children: <Widget>[
            ClipRect(
              child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                height: MediaQuery.of(context).size.height / 2,
              ),
            ),
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "Select a category",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0),
                      delegate: SliverChildBuilderDelegate(
                        _buildCategoryItem,
                        childCount: categories.length,
                      )),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    Category category = categories[index];
    return MaterialButton(
      elevation: 1.0,
      highlightElevation: 1.0,
      onPressed: () => _categoryPressed(context, category),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      textColor: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (category.icon != null)
            Icon(
              category.icon,
              color: Colors.deepOrange,
              size: 40,
            ),
          if (category.icon != null) SizedBox(height: 5.0),
          AutoSizeText(
            category.name,
            minFontSize: 10.0,
            textAlign: TextAlign.center,
            maxLines: 3,
            wrapWords: false,
          ),
        ],
      ),
    );
  }

  _categoryPressed(BuildContext context, Category category) {
//    new SimpleDialog(
//      title: new Text('Test'),
//      children: <Widget>[
//         QuizOptionsDialog(category: category,),
//      ],
//    );

    showDialog(
        context: context,
        child: new AlertDialog(
          content: Container(
              width: 400.0,
              child: QuizOptionsDialog(
                category: category,
              )),
        ));
//    showModalBottomSheet(
//      context: context,
//      builder: (sheetContext) => Padding(
//        padding:  EdgeInsets.fromLTRB(8, 8, 8,  AdSize.smartBanner.height.toDouble()),
//        child: BottomSheet(
//          builder: (_) => Padding(
//            padding:  EdgeInsets.fromLTRB(8, 8, 8,  AdSize.smartBanner.height.toDouble()),
//            child: QuizOptionsDialog(category: category,),
//          ),
//          onClosing: (){},
//
//        ),
//      ),
//
//    );
  }
}
