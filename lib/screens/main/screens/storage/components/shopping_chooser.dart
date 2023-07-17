import 'package:flutter/material.dart';
import 'package:fridsch_app/bl/api/shopping_list.service.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

Future<String> showShoppingChooser(context) async {
  String res = '';
  await showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      children: [
        const SizedBox(height: kDefPadding),
        Text(
          'Choose Shopping List',
          style: GoogleFonts.quicksand(
            fontSize: 22,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(kDefPadding),
            child: FutureBuilder(
              builder: (context, snapshot) => snapshot.hasData
                  ? ListView.separated(
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          print(snapshot.data![index].name);
                          res = snapshot.data![index].name;
                          Navigator.pop(context);
                        },
                        child: ListTile(
                          title: Text(
                            snapshot.data![index].name,
                            style: GoogleFonts.nunito(),
                          ),
                          leading: Text(
                            snapshot.data![index].emoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context, index) => const Divider(),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              future: ShoppingListService().getShoppingLists(),
            ),
          ),
        ),
      ],
    ),
  );
  return res;
}
