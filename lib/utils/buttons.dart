import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/neopop.dart';
import 'package:quizbox/utils/typography.dart';

NeoPopButton getNeoPopButton(String text, Color buttonColor, Color fontColor, String route, BuildContext context) {
  return NeoPopButton(
    color: buttonColor,
    onTapDown: () {HapticFeedback.selectionClick();
     Navigator.of(context).pushNamed(route);},
    onTapUp: () => HapticFeedback.selectionClick(),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          typoC(text, 20, "Open Sans", fontColor),
          Icon(Icons.arrow_forward_ios_rounded, color: fontColor),
        ],
      ),
    ),
  );
}

// Navigator.of(context).pushNamed(formRoute);