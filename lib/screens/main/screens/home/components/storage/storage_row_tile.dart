import 'package:flutter/material.dart';
import 'package:fridsch_app/bl/api/models/storage.dart';
import 'package:fridsch_app/screens/main/screens/storage/storage_screen.dart';

import '../../../../../../constants.dart';

class StorageRowTile extends StatelessWidget {
  const StorageRowTile({
    Key? key,
    required this.storage,
  }) : super(key: key);

  final Storage storage;

  @override
  Widget build(BuildContext context) {
    onTap() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StorageDetailScreen(storage: storage)));
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kDefPadding / 2),
        //height: 195,
        width: 175,
        decoration: BoxDecoration(
          borderRadius: kDefBorderRadius,
          color: kOnBackgroundColour,
        ),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Text(storage.emoji, style: const TextStyle(fontSize: 40)),
            const Spacer(),
            Container(
              width: 175,
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefPadding / 1.5),
              child: Text(
                '${storage.name} • ${storage.len ?? '…'}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
