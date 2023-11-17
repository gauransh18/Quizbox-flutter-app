// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/neopop.dart';
import 'package:quizbox/utils/typography.dart';

NeoPopButton getNeoPopButton(String text, Color buttonColor, Color fontColor,
    String route, BuildContext context) {
  return NeoPopButton(
    color: buttonColor,
    onTapDown: () {
      HapticFeedback.selectionClick();
      Navigator.of(context).pushNamed(route);
    },
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

NeoPopButton getNeoPopButtonF(String text, Color buttonColor, Color fontColor,
    String route, BuildContext context, void Function() tapdown) {
  return NeoPopButton(
    color: buttonColor,
    onTapDown: () {
      HapticFeedback.selectionClick();
      Navigator.of(context).pushNamed(route);
      tapdown();
    },
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

Widget getSubmitButton(BuildContext context, Function onPressed, String text) {
  if (text == "Next") {
    return NeoPopButton(
      color: Colors.white,
      onTapDown: () {
        HapticFeedback.selectionClick();
        onPressed();
      },
      onTapUp: () => HapticFeedback.selectionClick(),
      child: Container(
      
        width: 150, 
        height: 50, 
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Next",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Open Sans",
                  color: const Color.fromARGB(
                      255, 25, 25, 25), // Set your desired font color
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: const Color.fromARGB(255, 25, 25, 25)),
            ],
          ),
        ),
      ),
    );
  } else {
    return NeoPopTiltedButton(
      isFloating: true,
      onTapUp: () 
      {
        HapticFeedback.selectionClick();
        onPressed();
      },
      decoration: const NeoPopTiltedButtonDecoration(
        color: Color.fromRGBO(255, 235, 52, 1),
        plunkColor: Color.fromRGBO(255, 235, 52, 1),
        shadowColor: Color.fromRGBO(36, 36, 36, 1),
        showShimmer: true,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 70.0,
          vertical: 15,
        ),
        child: Text("Submit"),
      ),
    );
  }
}
