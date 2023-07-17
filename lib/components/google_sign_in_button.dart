import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    super.key,
    required this.loginFunction,
  });

  final Function loginFunction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => loginFunction(),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(325 / 375 * MediaQuery.of(context).size.width, 58),
        backgroundColor: kBackgroundColour,
        foregroundColor: kDarkContentColour,
        textStyle: GoogleFonts.quicksand(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: kDefBorderRadius),
        elevation: 7,
      ),
      child: Row(
        children: [
          const Spacer(),
          SvgPicture.asset('assets/imgs/g_logo.svg'),
          const Spacer(flex: 3),
          Text(
            'Continue with Google',
            style: GoogleFonts.quicksand(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: kDarkContentColour),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
