import 'package:dio/dio.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:fridsch_app/bl/api/models/item.dart';
import 'package:fridsch_app/bl/api/user.service.dart';

import 'connection.service.dart';
import 'models/category.dart';
import 'models/unit.dart';

class ItemService {
  static final ItemService _instance = ItemService._internal();

  ItemService._internal();

  factory ItemService() => _instance;

  Future<List<Item>> getItems(int householdId) async {
    var res = await kDio.post('/items',
        data: {
          "id": householdId,
        },
        options: Options(
          headers: {"Authorization": "Bearer ${UserService().token}"},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    print('getItems');

    return itemFromJson(res.data as List);
  }

  Future<List<Item>> getFilteredItems(int householdId, String filter) async {
    var res = await kDio.post('/items/filter',
        data: {
          "id": householdId,
          "filter": filter,
        },
        options: Options(
          headers: {"Authorization": "Bearer ${UserService().token}"},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    print('filterItems');

    return itemFromJson(res.data as List);
  }

  Future<Item> createItem(Item item, Unit unit, Category category) async {
    var res = await kDio.post('/items/create',
        data: {
          "name": item.name,
          "standardUnitAmount": 1,
          "unit": unit.id,
          "category": category.id,
          "createdBy": HouseholdService().currentHousehold,
          "h_id": HouseholdService().currentHousehold,
        },
        options: Options(
          headers: {"Authorization": "Bearer ${UserService().token}"},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    print('createItem');

    return Item.fromJson(res.data);
  }
}
