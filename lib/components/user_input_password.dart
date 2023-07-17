import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math; // import this

class PasswordUserInput extends StatefulWidget {
  const PasswordUserInput({
    Key? key,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;

  @override
  _PasswordUserInputState createState() => _PasswordUserInputState();
}

class _PasswordUserInputState extends State<PasswordUserInput> {
  bool isFocused = false;
  bool obscure = true;

  FocusNode _node = new FocusNode();

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
          constraints: BoxConstraints.tight(Size(double.infinity, 58)),
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
              FontAwesomeIcons.lock,
              size: 19,
              color: kDarkGreyContentColour,
            ),
          ),
          // Transform(
          //   alignment: Alignment.center,
          //   transform: Matrix4.rotationY(math.pi),
          //   child: Transform.rotate(
          //     angle: .7,
          //     child: const Icon(
          //       BootstrapIcons.key,
          //       size: 23,
          //       color: kDarkContentColour,
          //     ),
          //   ),
          // ),
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
