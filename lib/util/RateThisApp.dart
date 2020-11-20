import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
//  app_review: ^1.1.2  --- update this package in pubspsc
class RateThisApp{
  static void  openRatingPage(){
    print('"Opening Rating Page');
    AppReview.storeListing.then((String onValue) {
//                    setState(() {
//                      output = onValue;
//                    });
//                    print(onValue);
    });
  }
}