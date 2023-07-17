import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberInput extends StatelessWidget {
  const NumberInput(
      {super.key,
      required this.controller,
      required this.icon,
      required this.hint});

  final TextEditingController controller;
  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.w600),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        constraints: BoxConstraints.tight(const Size(double.infinity, 58)),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14),
          child: FaIcon(
            icon,
            color: kDarkGreyContentColour,
            size: 17,
          ),
        ),
        filled: true,
        fillColor: kOnBackgroundColour,
        hintText: hint,
        hintStyle: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: kGreyContentColour),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
