import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/bl/api/category.service.dart';
import 'package:fridsch_app/bl/api/models/shoppinglistitem.dart';
import 'package:fridsch_app/bl/api/shopping_list.service.dart';
import 'package:fridsch_app/bl/api/shoppinglistitem.service.dart';
import 'package:fridsch_app/constants.dart';
import 'package:fridsch_app/screens/main/screens/home/components/loading_list.dart';
import 'package:fridsch_app/screens/main/screens/home/shopping/components/add_shopping_item.dart';
import 'package:fridsch_app/screens/main/screens/home/shopping/components/storageChooser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fridsch_app/bl/api/models/category.dart';
import '../../../../../bl/api/models/shopping_list.dart';
import '../../storage/components/search_bar.dart';

class ShoppingDetailScreen extends StatefulWidget {
  const ShoppingDetailScreen({super.key, required this.list});

  final ShoppingList list;

  @override
  State<ShoppingDetailScreen> createState() => _ShoppingDetailScreenState();
}

class _ShoppingDetailScreenState extends State<ShoppingDetailScreen> {
  late Future<List<ShoppingListItem>> items;
  List<ShoppingListItem>? filtered_items;

  @override
  void initState() {
    items = ShoppingListItemService()
        .getItems(widget.list.householdId, widget.list.name);
    items.then((value) =>
        {setState(() => filtered_items = List.from(value, growable: true))});
    initialize();
    super.initState();
  }

  Future<bool> checkIfInItems(ShoppingListItem item) async {
    return (await items).any((e) => item.itemId == e.itemId);
  }

  void initialize() async {
    final items = await ShoppingListItemService().getAddables(widget.list);
    await this.items.then((value) => {
          items.removeWhere(
              (element) => value.any((e) => element.itemId == e.itemId))
        });

    if (items.isEmpty) {
      return;
    } else {
      await Future.delayed(const Duration(seconds: 2));
      final snackBar = SnackBar(
        content: Text(
          'Our AI thinks you should add Items. Want to try it out?',
          style: GoogleFonts.nunito(
            color: kDarkGreyContentColour,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        duration: const Duration(seconds: 6),
        action: SnackBarAction(
            label: 'Add',
            onPressed: () async {
              for (final item in items) {
                await ShoppingListItemService().addItem(item);
              }
              this.items = ShoppingListItemService()
                  .getItems(widget.list.householdId, widget.list.name);
              this.items.then((value) => {
                    setState(
                        () => filtered_items = List.from(value, growable: true))
                  });
            }),
        behavior: SnackBarBehavior.floating,
        backgroundColor: kOnBackgroundColour,
        shape: RoundedRectangleBorder(borderRadius: kDefBorderRadius),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  deleteItemCallback(ShoppingListItem item) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Deleted ${item.item.name}')));
    ShoppingListItemService().delete(item);
    items.then((value) => {
          value.remove(item),
          setState(() {
            searchCallback('');
          })
        });
  }

  addItemCallback(ShoppingListItem item) async {
    item.fridgeName = widget.list.name;

    if (!(await ShoppingListItemService().addItem(item))) {
      return;
    }

    setState(() {
      items.then((value) => value.add(item));
    });
    searchCallback('');
  }

  searchCallback(String filter) async {
    print(filter);
    // Todo filter list

    await items
        .then((value) => filtered_items = List.from(value, growable: true));
    setState(() {
      filtered_items!.removeWhere((element) =>
          !element.item.name.toLowerCase().contains(filter.toLowerCase()));
    });
    print(filtered_items);
  }

  @override
  Widget build(BuildContext context) {
    print('shopping_screen');
    return Scaffold(
      backgroundColor: kBackgroundColour,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: kDefPadding),
            Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefPadding * 1.5),
              child: Text(
                '${widget.list.emoji} ${widget.list.name}',
                style: GoogleFonts.quicksand(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: kDefPadding),
            SizedBox(
              width: MediaQuery.of(context).size.width * .85,
              child: Row(
                children: [
                  Expanded(
                      child: FridschSearchBar(
                    callback: searchCallback,
                    hint: 'Search',
                  )),
                  const SizedBox(width: kDefPadding / 2),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddShoppingItemScreen(
                                  addItem: addItemCallback,
                                )));
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: kOnBackgroundColour,
                        foregroundColor: kDarkGreyContentColour,
                        elevation: 0,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.plus,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefPadding * .5),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * .85,
                decoration: BoxDecoration(
                    color: kOnBackgroundColour, borderRadius: kDefBorderRadius),
                child: FutureBuilder(
                  future: items,
                  builder: (context, snapshot) => snapshot.hasData
                      ? ListView.builder(
                          // todo make dismissible extra widget
                          itemBuilder: (context, index) => Dismissible(
                                key: Key(filtered_items![index].item.name),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) =>
                                    deleteItemCallback(filtered_items![index]),
                                background: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xffff595e),
                                      borderRadius: kDefBorderRadius),
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          right: kDefPadding),
                                      alignment: Alignment.centerRight,
                                      child: const FaIcon(
                                        FontAwesomeIcons.trashCan,
                                        color: kOnBackgroundColour,
                                      )),
                                ),
                                child: ShoppingListItemListTile(
                                    item: filtered_items![index]),
                              ),
                          itemCount: filtered_items?.length ?? 0)
                      : const LoadingList(),
                ),
              ),
            ),
            const SizedBox(height: kDefPadding * .5),
            TextButton(
              onPressed: () async {
                //todo show storages and then put in selected storage
                String storageName = await showStorageChooser(context);
                print(storageName);
                if (storageName.isEmpty) {
                  return;
                }
                if (!await widget.list.finish(storageName)) {
                  //! throw error
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text('An error occured.')));
                } else {
                  items.then((value) =>
                      value.removeWhere((element) => element.isDone));
                  setState(() {
                    searchCallback('');
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Shopping finished succesfully!')));
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 63, 207, 140),
                backgroundColor: Color.fromARGB(80, 73, 233, 158),
                shape: RoundedRectangleBorder(borderRadius: kDefBorderRadius),
                fixedSize:
                    Size(325 / 375 * MediaQuery.of(context).size.width, 55),
              ),
              child: Text(
                'Finish Shopping',
                style: GoogleFonts.nunito(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: kDefPadding),
          ],
        ),
      ),
    );
  }
}

class ShoppingListItemListTile extends StatefulWidget {
  const ShoppingListItemListTile({
    super.key,
    required this.item,
  });

  final ShoppingListItem item;

  @override
  State<ShoppingListItemListTile> createState() =>
      _ShoppingListItemListTileState();
}

class _ShoppingListItemListTileState extends State<ShoppingListItemListTile> {
  late bool selected;

  @override
  void initState() {
    selected = widget.item.isDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: selected,
      title: Text(widget.item.item.name),
      subtitle: Text('${widget.item.quantity}${widget.item.unit.shortname}'),
      onChanged: (bool? value) async {
        final item = widget.item;
        item.isDone = value!;
        if (!(await ShoppingListItemService().changeStatus(item))) {
          return;
        }
        setState(() {
          selected = value;
        });
      },
    );
  }
}
