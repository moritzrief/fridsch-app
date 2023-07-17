import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await Future.delayed(Duration(seconds: 1));
    if (false) {
      Navigator.of(context).pushReplacementNamed('/household');
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kBackgroundColour, kRevollutBackgroundColour])),
        child: SafeArea(
            child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  left: kDefPadding * 2,
                  right: kDefPadding * 2,
                  top: kDefPadding),
              child: Text(
                'Welcome to',
                textAlign: TextAlign.left,
                style: GoogleFonts.domine(
                    fontSize: 48,
                    color: kDarkContentColour,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: kDefPadding / 2),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: kDefPadding * 2),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TyperAnimatedText(
                    ':fridsch:',
                    speed: const Duration(milliseconds: 60),
                    textStyle: GoogleFonts.domine(
                        fontSize: 48,
                        color: kPrimaryColour,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(kDefPadding),
            //   width: 325 / 375 * MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     borderRadius: kDefBorderRadius,
            //     color: kOnBackgroundColour,
            //   ),
            //   child: Column(
            //     children: [
            //       Container(
            //         width: MediaQuery.of(context).size.width,
            //         child: Text(
            //           'Lorem Ipsum Dollar sit amet.',
            //           textAlign: TextAlign.left,
            //           style: GoogleFonts.openSans(fontSize: 20),
            //         ),
            //       ),
            //       const SizedBox(height: kDefPadding / 2),
            //       Container(
            //         width: MediaQuery.of(context).size.width,
            //         child: AnimatedTextKit(
            //           repeatForever: true,
            //           animatedTexts: [
            //             TyperAnimatedText('easier',
            //                 speed: const Duration(milliseconds: 60),
            //                 textStyle: GoogleFonts.openSans(
            //                     fontSize: 20, fontWeight: FontWeight.bold)),
            //             TyperAnimatedText('healthier',
            //                 speed: const Duration(milliseconds: 60),
            //                 textStyle: GoogleFonts.openSans(
            //                     fontSize: 20, fontWeight: FontWeight.bold)),
            //             TyperAnimatedText('more relaxed',
            //                 speed: const Duration(milliseconds: 60),
            //                 textStyle: GoogleFonts.openSans(
            //                     fontSize: 20, fontWeight: FontWeight.bold)),
            //             TyperAnimatedText('more informed',
            //                 speed: const Duration(milliseconds: 60),
            //                 textStyle: GoogleFonts.openSans(
            //                     fontSize: 20, fontWeight: FontWeight.bold)),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/register');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: kDarkContentColour,
                    backgroundColor: kOnBackgroundColour,
                    shape:
                        RoundedRectangleBorder(borderRadius: kDefBorderRadius),
                    fixedSize:
                        Size(158 / 375 * MediaQuery.of(context).size.width, 75),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: kDarkContentColour,
                    backgroundColor: kOnBackgroundColour,
                    shape:
                        RoundedRectangleBorder(borderRadius: kDefBorderRadius),
                    fixedSize:
                        Size(158 / 375 * MediaQuery.of(context).size.width, 75),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
            const SizedBox(height: kDefPadding),
          ],
        )),
      ),
    );
  }
}
