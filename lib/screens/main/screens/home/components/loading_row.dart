import 'package:flutter/material.dart';

import 'loading_row_tile.dart';

class LoadingRow extends StatelessWidget {
  const LoadingRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) => const LoadingRowTile(),
    );
  }
}
