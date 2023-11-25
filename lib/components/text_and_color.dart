import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const blueBackgroundColor = Color.fromARGB(255, 27, 139, 164);
const blueAppBarColor = Color.fromARGB(255, 16, 79, 94);

final restaurauntTitleTextStyle =
    GoogleFonts.quattrocento(fontSize: 30, color: Colors.white);
//final restaurauntTitleTextStyle = GoogleFonts.yujiBoku(fontSize: 30, color: Colors.white);

var menuSubTitleTextStyle =
    GoogleFonts.quattrocento(fontSize: 20, color: Colors.white);
var hintTextStyle = GoogleFonts.quattrocento(fontSize: 10, color: Colors.white);
var foodTextStyle = GoogleFonts.alice(
    fontSize: 15, color: const Color.fromRGBO(255, 255, 255, 1));

var addRecipeStyleSearch = GoogleFonts.quattrocento(
  fontSize: 15,
  color: Colors.white,
  fontStyle: FontStyle.italic,
);
var addRecipeStyleSearchHint = GoogleFonts.quattrocento(
  fontSize: 12,
  color: Colors.white,
  fontWeight: FontWeight.w100,
  fontStyle: FontStyle.italic,
);

const textThemeCustom = TextTheme(
  displayLarge: TextStyle(color: Colors.white),
  displayMedium: TextStyle(color: Colors.white),
  displaySmall: TextStyle(color: Colors.white),
);
