import 'package:flutter/material.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkContentColour,
      body: Center(
          heightFactor: 3.5,
          child: Shimmer.fromColors(
              baseColor: kPrimaryColour,
              highlightColor: kOnBackgroundColour,
              child: Text(
                ':f:',
                style: GoogleFonts.quicksand(fontSize: 200),
              ))),
    );
  }
}
