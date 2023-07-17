import 'package:flutter/material.dart';

import '../constants.dart';

class EditEmojiRow extends StatefulWidget {
  const EditEmojiRow(
      {super.key,
      required this.callback,
      required this.emojiList,
      required this.emoji});

  final Function callback;
  final String emoji;
  final Map<String, Color> emojiList;

  @override
  State<EditEmojiRow> createState() => _EditEmojiRowState();
}

class _EditEmojiRowState extends State<EditEmojiRow> {
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.emojiList.keys.toList().indexOf(widget.emoji);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.emojiList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => EmojiRowTile(
          emoji: widget.emojiList.keys.elementAt(index),
          colour:
              widget.emojiList[widget.emojiList.keys.elementAt(index)] as Color,
          onTap: () {
            widget.callback(widget.emojiList.keys.elementAt(index));
            setState(() {
              selectedIndex = index;
            });
          },
          selected: selectedIndex == index,
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 7.5),
      ),
    );
  }
}

class EmojiRowTile extends StatelessWidget {
  const EmojiRowTile({
    super.key,
    required this.emoji,
    required this.colour,
    required this.onTap,
    required this.selected,
  });

  final String emoji;
  final Color colour;
  final Function onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
            color: selected
                ? colour.withOpacity(.7)
                : colour
                    .withOpacity(.2), //kGreyContentColour.withOpacity(.2), //
            borderRadius: kDefBorderRadius,
            border: selected ? Border.all(color: colour, width: 3) : null),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 36),
          ),
        ),
      ),
    );
  }
}
