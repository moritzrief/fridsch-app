import 'package:flutter/material.dart';

import '../../../../../../bl/api/models/storage.dart';
import 'storage_row_tile.dart';

class StorageRow extends StatelessWidget {
  const StorageRow(
    this.storages, {
    Key? key,
  }) : super(key: key);

  final List<Storage> storages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: storages.length,
      itemBuilder: (context, index) =>
          StorageRowTile(storage: storages[index]),
    );
  }
}