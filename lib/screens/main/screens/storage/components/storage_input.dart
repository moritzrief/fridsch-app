import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class StorageInput extends StatelessWidget {
  const StorageInput({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final node = FocusNode();
    node.requestFocus();

    return TextFormField(
      controller: controller,
      focusNode: node,
      style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.w600),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        constraints: BoxConstraints.tight(const Size(double.infinity, 58)),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(14),
          child: FaIcon(
            FontAwesomeIcons.box,
            color: kDarkGreyContentColour,
            size: 17,
          ),
        ),
        filled: true,
        fillColor: kOnBackgroundColour,
        hintText: 'Storage Name',
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
