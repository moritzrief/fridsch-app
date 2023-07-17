import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class SuffixUserInput extends StatefulWidget {
  SuffixUserInput({
    Key? key,
    required this.hint,
    required this.suffixIcon,
    required this.keyboardType,
  }) : super(key: key);

  final String hint;
  final IconData suffixIcon;
  final keyboardType;

  @override
  _SuffixUserInputState createState() => _SuffixUserInputState();
}

class _SuffixUserInputState extends State<SuffixUserInput> {
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
        focusNode: _node,
        style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.w600),
        obscureText: widget.keyboardType == TextInputType.visiblePassword,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          constraints: BoxConstraints.tight(Size(double.infinity, 58)),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isFocused ? kPrimaryColour : Color(0xFFEFF4F5),
              ),
              child: Icon(
                widget.suffixIcon,
                size: 19,
                color: isFocused ? kBackgroundColour : kBlack,
              ),
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
