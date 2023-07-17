import 'package:flutter/material.dart';

import 'loading_wrap_tile.dart';

class LoadingWrap extends StatelessWidget {
  const LoadingWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ...List.generate(7, (index) => const LoadingCategoryWrapTile()),
      ],
    );
  }
}
