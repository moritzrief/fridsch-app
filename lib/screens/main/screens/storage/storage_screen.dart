import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/bl/api/category.service.dart';
import 'package:fridsch_app/bl/api/models/shoppinglistitem.dart';
import 'package:fridsch_app/bl/api/models/storage.dart';
import 'package:fridsch_app/bl/api/storageitem.service.dart';
import 'package:fridsch_app/constants.dart';
import 'package:fridsch_app/screens/main/screens/home/components/loading_list.dart';
import 'package:fridsch_app/screens/main/screens/storage/components/add_storage_item.dart';
import 'package:fridsch_app/screens/main/screens/storage/components/shopping_chooser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fridsch_app/bl/api/models/category.dart';

import '../../../../bl/api/models/storage.item.dart';
import '../../../../bl/api/shoppinglistitem.service.dart';
import '../home/components/loading_wrap.dart';
import 'components/search_bar.dart';

class StorageDetailScreen extends StatefulWidget {
  const StorageDetailScreen({super.key, required this.storage});

  final Storage storage;

  @override
  State<StorageDetailScreen> createState() => _StorageDetailScreenState();
}

class _StorageDetailScreenState extends State<StorageDetailScreen> {
  late Future<List<StorageItem>> items;
  List<StorageItem>? filtered_items;

  @override
  void initState() {
    items = StorageItemService()
        .getItems(widget.storage.householdId, widget.storage.name);
    items.then((value) =>
        {setState(() => filtered_items = List.from(value, growable: true))});
    super.initState();
  }

  addItemCallback(StorageItem item) async {
    item.storageName = widget.storage.name;

    if (!(await StorageItemService().addItem(item))) {
      return;
    }

    items = StorageItemService()
        .getItems(widget.storage.householdId, widget.storage.name);
    items.then((value) =>
        {setState(() => filtered_items = List.from(value, growable: true))});
    widget.storage.len = widget.storage.len! + 1;
  }

  categoryCallback(Category category) async {
    print(category.name);
    // Todo filter list by category
    await items
        .then((value) => filtered_items = List.from(value, growable: true));
    setState(() {
      category.id != -1
          ? filtered_items!
              .removeWhere((element) => element.category.id != category.id)
          : null;
    });
    print(filtered_items);
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
    print('storage_screen');
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
                '${widget.storage.emoji} ${widget.storage.name}',
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
                      child: SearchBar(
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
                            builder: (context) => AddStorageItemScreen(
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
            CategoryChooser(callback: categoryCallback),
            const SizedBox(height: kDefPadding * .5),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * .85,
                decoration: BoxDecoration(
                    color: kOnBackgroundColour, borderRadius: kDefBorderRadius),
                child: FutureBuilder(
                  future: items,
                  builder: (context, snapshot) => snapshot.hasData
                      //todo seperate into widgets
                      ? ListView.builder(
                          itemBuilder: (context, index) => Dismissible(
                              key: Key(filtered_items![index].item.name),
                              background: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xff52b788),
                                    borderRadius: kDefBorderRadius),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        left: kDefPadding),
                                    alignment: Alignment.centerLeft,
                                    child: const FaIcon(
                                      FontAwesomeIcons.cartPlus,
                                      color: kOnBackgroundColour,
                                    )),
                              ),
                              secondaryBackground: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffff595e),
                                    borderRadius: kDefBorderRadius),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        right: kDefPadding),
                                    alignment: Alignment.centerRight,
                                    child: const FaIcon(
                                      FontAwesomeIcons.solidTrashCan,
                                      color: kOnBackgroundColour,
                                    )),
                              ),
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  final addItem = filtered_items![index];
                                  String shoppingName =
                                      await showShoppingChooser(context);
                                  print(shoppingName);
                                  if (shoppingName.isEmpty) {
                                    return false;
                                  }
                                  if (!(await ShoppingListItemService().addItem(
                                      ShoppingListItem(
                                          itemId: addItem.itemId,
                                          householdId: addItem.householdId,
                                          fridgeName: shoppingName,
                                          quantity: addItem.quantity,
                                          isDone: false,
                                          item: addItem.item,
                                          unit: addItem.unit)))) {
                                    // !notify user of fail
                                  }
                                  return false;
                                }
                                return true;
                              },
                              onDismissed: (direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  if (await StorageItemService()
                                      .delete(filtered_items![index])) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Deleted ${filtered_items![index].item.name}')));
                                    items.then((value) =>
                                        value.remove(filtered_items![index]));
                                    setState(() {
                                      categoryCallback(
                                          Category(id: -1, name: 'all'));
                                    });
                                    widget.storage.len =
                                        widget.storage.len! - 1;
                                  }
                                }
                              },
                              child: StorageItemListTile(
                                  item: filtered_items![index])),
                          itemCount: filtered_items?.length ?? 0)
                      : const LoadingList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StorageItemListTile extends StatelessWidget {
  const StorageItemListTile({
    super.key,
    required this.item,
  });

  final StorageItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.item.name),
      subtitle: Text('${item.quantity}${item.unit.shortname}'),
      leading: Padding(
        padding: const EdgeInsets.all(14),
        child: item.category.getIcon(),
      ),
    );
  }
}

class CategoryChooser extends StatefulWidget {
  const CategoryChooser({
    super.key,
    required this.callback,
  });

  final Function callback;

  @override
  State<CategoryChooser> createState() => _CategoryChooserState();
}

class _CategoryChooserState extends State<CategoryChooser> {
  late final Future<List<Category>> categories;

  @override
  void initState() {
    categories = CategoryService().getCategories();
    categories.then((value) => value.insert(0, Category(id: -1, name: 'All')));
    super.initState();
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: .075 * MediaQuery.of(context).size.width),
      decoration: BoxDecoration(borderRadius: kDefBorderRadius),
      child: FutureBuilder(
        future: categories,
        builder: (context, snapshot) => snapshot.hasData
            ? Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...List.generate(
                      snapshot.data!.length,
                      (index) => CategoryWrapTile(
                            snapshot.data![index].name,
                            selected: index == selected,
                            onTap: () {
                              setState(() {
                                if (selected == index) {
                                  return;
                                }
                                selected = index;
                                widget.callback(snapshot.data![index]);
                              });
                            },
                          )),
                ],
              )
            : const LoadingWrap(),
      ),
    );
  }
}

class CategoryWrapTile extends StatelessWidget {
  const CategoryWrapTile(
    this.category, {
    super.key,
    required this.selected,
    required this.onTap,
  });

  final String category;
  final bool selected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefPadding / 2,
            vertical: kDefPadding / 3,
          ),
          decoration: BoxDecoration(
              color: selected
                  ? Colors.white
                  : kOnBackgroundColour.withOpacity(.65),
              borderRadius: BorderRadius.circular(8)),
          child: Text(category,
              style: selected
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null)),
    );
  }
}
