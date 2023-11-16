import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



Widget typoL(String headingText, ) {
  double size = 20;
  return Text(headingText,
    style: GoogleFonts.bungeeHairline(
      fontSize: size,
      color: Colors.white70,
    ),
  );
}

Widget typoH(String headingText) {
  double size = 30;
  return Text(headingText,
    style: GoogleFonts.openSans(
      fontSize: size,
      color: Colors.white70,
    ),
  );
}

Widget typoB(String headingText) {
  double size = 15;
  return Text(headingText,
    textAlign: TextAlign.center,
    style: GoogleFonts.openSans(
      fontSize: size,
      color: Colors.white70,
    ),
  );
}

Widget typoC(String headingText, double size, String font, Color color) {
  return Text(headingText,
    textAlign: TextAlign.center,
    style: GoogleFonts.getFont(font,
      fontSize: size,
      color: color,
    ),
    
  );
}


