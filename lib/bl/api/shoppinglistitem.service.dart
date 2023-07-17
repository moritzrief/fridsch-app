import 'package:dio/dio.dart';
import 'package:fridsch_app/bl/api/models/shopping_list.dart';
import 'package:fridsch_app/bl/api/models/shoppinglistitem.dart';
import 'package:fridsch_app/bl/api/models/storage.item.dart';
import 'package:fridsch_app/bl/api/user.service.dart';

import 'connection.service.dart';
import 'models/storage.dart';

class ShoppingListItemService {
  static final ShoppingListItemService _instance =
      ShoppingListItemService._internal();

  ShoppingListItemService._internal();

  factory ShoppingListItemService() => _instance;

  Future<List<ShoppingListItem>> getItems(
      int householdId, String storageName) async {
    var res = await kDio.post('/shoppingitems',
        data: {
          "id": householdId,
          "name": storageName,
        },
        options: Options(
          headers: {"Authorization": "Bearer ${UserService().token}"},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    print('getShoppingListItems');

    return shoppingListItemFromJson(res.data as List);
  }

  Future<bool> addItem(ShoppingListItem item) async {
    var res = await kDio.post('/shoppingitems/create',
        data: {
          "item_id": item.itemId,
          "household_id": item.householdId,
          "fridge_name": item.fridgeName,
          "quantity": item.quantity,
          "unit": item.unit.id,
        },
        options: Options(
          headers: {"Authorization": "Bearer ${UserService().token}"},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    print('addShoppingListItem');

    return res.statusCode == 201;
  }

  Future<bool> changeStatus(ShoppingListItem item) async {
    var res = await kDio.post('/shoppingitems/changestatus',
        data: {
          "item_id": item.itemId,
          "id": item.householdId,
          "name": item.fridgeName,
          "status": item.isDone,
        },
        options: Options(
          headers: {"Authorization": "Bearer ${UserService().token}"},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    print('addShoppingListItem');

    return res.statusCode == 201 || res.statusCode == 200;
  }

  Future<bool> delete(ShoppingListItem item) async {
    var res = await kDio.post('/shoppingitems/delete',
        data: {
          "item_id": item.itemId,
          "id": item.householdId,
          "name": item.fridgeName,
        },
        options: Options(
          headers: {"Authorization": "Bearer ${UserService().token}"},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    print('deleteShoppingListItem');

    return res.statusCode == 201 ||
        res.statusCode == 200 ||
        res.statusCode == 203;
  }

  Future<List<ShoppingListItem>> getAddables(ShoppingList list) async {
    var res = await kDio.post('/shoppingitems/addable',
        data: {
          "household_id": list.householdId,
          "name": list.name,
        },
        options: Options(
          headers: {"Authorization": "Bearer ${UserService().token}"},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    print('getAddables');

    return shoppingListItemFromIncompleteJson(res.data);
  }
}
