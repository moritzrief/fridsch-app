import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class PrefixUserInput extends StatefulWidget {
  const PrefixUserInput({
    Key? key,
    required this.hint,
    required this.prefixIcon,
    required this.keyboardType,
    required this.controller,
  }) : super(key: key);

  final String hint;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;

  @override
  _PrefixUserInputState createState() => _PrefixUserInputState();
}

class _PrefixUserInputState extends State<PrefixUserInput> {
  bool isFocused = false;

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
        obscureText: widget.keyboardType == TextInputType.visiblePassword,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          constraints: BoxConstraints.tight(const Size(double.infinity, 58)),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: FaIcon(
              widget.prefixIcon,
              color: kDarkGreyContentColour,
              size: 19,
            ),
          ),
          filled: true,
          fillColor: kBackgroundColour,
          hintText: widget.hint,
          //labelText: widget.hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
