import 'package:flutter/material.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:fridsch_app/bl/api/storage.service.dart';
import 'package:fridsch_app/screens/main/screens/home/components/loading_row.dart';
import 'package:fridsch_app/screens/main/screens/storage/add/add_storage_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../bl/api/models/storage.dart';
import '../../../../../../constants.dart';
import 'storage_row.dart';

class StorageElement extends StatefulWidget {
  const StorageElement({super.key});

  @override
  State<StorageElement> createState() => _StorageElementState();
}

class _StorageElementState extends State<StorageElement> {
  late Future<List<Storage>> storages;
  bool _isLoaded = false;

  @override
  void initState() {
    storages =
        StorageService().getStorages(HouseholdService().currentHousehold);
    int count = 0;
    storages.whenComplete(() => setState(() => _isLoaded = true));
    storages.then((value) => value.forEach((element) {
          element.getLength().whenComplete(() {
            setState(() {});
          });
        }));
    super.initState();
  }

  addStorageCallback(Storage newStorage) {
    setState(() {
      storages.then((value) => value.add(newStorage));
    });
  }

  addStorage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddStorageScreen(addStorage: addStorageCallback),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefPadding * 1.5),
            margin: const EdgeInsets.only(bottom: kDefPadding / 2),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Storages', style: TextStyle(fontSize: 17)),
                TextButton(
                  onPressed: _isLoaded ? addStorage : null,
                  style: TextButton.styleFrom(
                    foregroundColor: kPrimaryColour,
                    backgroundColor: kPrimaryColour.withOpacity(.15),
                    shape:
                        RoundedRectangleBorder(borderRadius: kDefBorderRadius),
                  ),
                  child: Text(
                    '+ Add',
                    style: GoogleFonts.quicksand(fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )),
        Container(
          height: 185,
          padding: const EdgeInsets.symmetric(horizontal: kDefPadding / 2),
          child: FutureBuilder(
              future: storages,
              builder: (context, snapshot) => snapshot.hasData
                  ? StorageRow(snapshot.data!)
                  : const LoadingRow()),
        ),
      ],
    );
  }
}
