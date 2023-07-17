import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/bl/api/user.service.dart';
import 'package:fridsch_app/components/google_sign_in_button.dart';
import 'package:fridsch_app/components/header.dart';
import 'package:fridsch_app/components/user_input_password.dart';
import 'package:fridsch_app/components/user_input_prefix.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/repeat_password_input.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    googleLogin() async {
      final token = await UserService().loginWithGoogle();
      if (token != null) {
        Navigator.pushReplacementNamed(context, '/household');
      }
    }

    register() async {
      final String name = nameController.text;
      final String email = emailController.text;
      final String pwd = passwordController.text;

      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'No field must be empty!',
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

      if (pwd != repeatPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Passwords are different!',
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
        return;
      }

      final token = await UserService().register(name, email, pwd);

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

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [kRevollutBackgroundColour, kBackgroundColour]),
        ),
        child: SingleChildScrollView(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(height: kDefPadding * 3),
              ThreeTextHeader(
                pageName: 'Register',
                title: 'Welcome Stranger!',
                subtitle:
                    'We\'d love to get to know you!\nLet\'s get you signed up.',
                pageNameStyle: kScreenHeaderTextStyle,
                titleStyle: GoogleFonts.quicksand(
                  fontSize: 38,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColour,
                ),
                subtitleStyle: const TextStyle(fontSize: 24),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: kDefPadding),
                child: Column(
                  children: [
                    PrefixUserInput(
                      hint: 'Display Name',
                      prefixIcon: FontAwesomeIcons.solidUser,
                      keyboardType: TextInputType.name,
                      controller: nameController,
                    ),
                    const SizedBox(height: kDefPadding),
                    PrefixUserInput(
                      hint: 'Email',
                      prefixIcon: FontAwesomeIcons.solidEnvelope,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    const SizedBox(height: kDefPadding * 1.5),
                    PasswordUserInput(
                      hint: 'Password',
                      controller: passwordController,
                    ),
                    const SizedBox(height: kDefPadding),
                    RepeatPasswordInput(
                      hint: 'Repeat Password',
                      controller: repeatPasswordController,
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 4),
              TextButton(
                child: Text(
                  'Already a member? Login',
                  style: GoogleFonts.nunito(color: kDarkContentColour),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
              GoogleSignInButton(loginFunction: googleLogin),
              const SizedBox(height: kDefPadding),
              ElevatedButton(
                onPressed: () => register(),
                style: ElevatedButton.styleFrom(
                  fixedSize:
                      Size(325 / 375 * MediaQuery.of(context).size.width, 58),
                  backgroundColor: kPrimaryColour,
                  foregroundColor: kOnBackgroundColour,
                  textStyle: GoogleFonts.quicksand(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: kDefBorderRadius),
                  elevation: 7,
                  shadowColor: kPrimaryColour,
                ),
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: kDefPadding * 2),
            ],
          ),
        )),
      ),
    );
  }
}
