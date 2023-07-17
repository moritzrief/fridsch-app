import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/bl/api/user.service.dart';
import 'package:fridsch_app/components/user_input_password.dart';
import 'package:fridsch_app/components/user_input_prefix.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/google_sign_in_button.dart';
import '../../components/header.dart';
import '../../constants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    login() async {
      final email = emailController.text;
      final pwd = passwordController.text;

      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        final snackBar = SnackBar(
          content: Text(
            'Fields must not be empty!',
            style: GoogleFonts.nunito(
              color: kDarkGreyContentColour,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: kOnBackgroundColour,
          shape: RoundedRectangleBorder(borderRadius: kDefBorderRadius),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      final token = await UserService().login(email, pwd);

      if (token != null) {
        Navigator.pushReplacementNamed(context, '/household');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'An errorr occured!',
            style: GoogleFonts.nunito(
              color: kDarkGreyContentColour,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: kOnBackgroundColour,
          shape: RoundedRectangleBorder(borderRadius: kDefBorderRadius),
        ));
      }
    }

    googleLogin() async {
      final token = await UserService().loginWithGoogle();
      if (token != null) {
        Navigator.pushReplacementNamed(context, '/household');
      }
    }

    return Scaffold(
      backgroundColor: kPrimaryColour,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(height: kDefPadding * 3),
              ThreeTextHeader(
                pageName: 'Login',
                title: 'Welcome Back!',
                subtitle:
                    'You\'ve been missed!\nLet\'s go and get you signed in.',
                pageNameStyle:
                    kScreenHeaderTextStyle.copyWith(color: kBackgroundColour),
                titleStyle: GoogleFonts.quicksand(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: kBackgroundColour,
                ),
                subtitleStyle: TextStyle(fontSize: 24),
              ),
              const Spacer(),
              Container(
                //height: MediaQuery.of(context).size.height * .50,
                padding: const EdgeInsets.symmetric(horizontal: kDefPadding),
                child: Column(
                  children: [
                    PrefixUserInput(
                      hint: 'Email',
                      prefixIcon: FontAwesomeIcons.envelope,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    const SizedBox(height: kDefPadding),
                    PasswordUserInput(
                      hint: 'Password',
                      controller: passwordController,
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 4),
              TextButton(
                child: Text(
                  'Not already a member? Register',
                  style: GoogleFonts.nunito(color: kBackgroundColour),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/register');
                },
              ),
              GoogleSignInButton(loginFunction: googleLogin),
              const SizedBox(height: kDefPadding),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  fixedSize:
                      Size(325 / 375 * MediaQuery.of(context).size.width, 58),
                  backgroundColor: kBackgroundColour,
                  foregroundColor: kPrimaryColour,
                  textStyle: GoogleFonts.quicksand(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: kDefBorderRadius),
                  elevation: 7,
                ),
                child: const Text('Sign In'),
              ),
              const SizedBox(height: kDefPadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}
