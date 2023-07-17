import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///
/// Colours
///
const kPrimaryColour = Color.fromARGB(255, 96, 106, 255);
const kSecondaryColour = Color(0xff6FE1AC);
const kBackgroundColour = Color(0xffF2F4F5);
const kOnBackgroundColour = Color(0xffFEFEFE);
const kRevollutBackgroundColour = Color(0xffEDEFF2);

const kDarkContentColour = Color(0xff1C1B1E); //201E53);
const kDarkGreyContentColour = Color(0xff515151);
const kGreyContentColour = Color(0xffB1B1B1);
//const kDarkTextColour = Color(0xff1C1B1E);

const kBlack = Color(0xff252525);

///
/// Element Styles
///
const kDefPadding = 20.0;

BorderRadius kDefBorderRadius = BorderRadius.circular(15);

///
/// Text Styles
///
TextStyle kDefTextStyle = GoogleFonts.openSans(
  fontSize: 16,
  color: kDarkContentColour,
  fontWeight: FontWeight.w600,
);

TextStyle kScreenHeaderTextStyle = GoogleFonts.quicksand(
  fontSize: 20,
  color: kPrimaryColour,
);
