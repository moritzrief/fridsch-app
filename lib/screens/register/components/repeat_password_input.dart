import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math; // import this

class RepeatPasswordInput extends StatefulWidget {
  const RepeatPasswordInput({
    Key? key,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;

  @override
  _RepeatPasswordInputState createState() => _RepeatPasswordInputState();
}

class _RepeatPasswordInputState extends State<RepeatPasswordInput> {
  bool isFocused = false;
  bool obscure = true;

  final _node = FocusNode();

  @override
  void initState() {
    super.initState();
    _node.addListener(_nodeListener);
  }

  @override
  void dispose() {
    _node.removeListener(_nodeListener);
    super.dispose();
  }

  Future<Null> _nodeListener() async {
    if (_node.hasFocus) {
      setState(() => isFocused = true);
    } else {
      setState(() => isFocused = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(15),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _node,
        style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.w600),
        obscureText: obscure,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          constraints: BoxConstraints.tight(const Size(double.infinity, 58)),
          suffixIcon: GestureDetector(
            onTap: () => setState(() {
              obscure = !obscure;
            }),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: FaIcon(
                obscure ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                size: 19,
                color: kDarkGreyContentColour,
              ),
            ),
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(15),
            child: FaIcon(
              FontAwesomeIcons.repeat,
              size: 19,
              color: kDarkGreyContentColour,
            ),
          ),
          filled: true,
          fillColor: kBackgroundColour,
          hintText: widget.hint,
          //labelText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
