import 'package:dio/dio.dart';
import 'package:fridsch_app/bl/api/models/storage.item.dart';
import 'package:fridsch_app/bl/api/user.service.dart';

import 'connection.service.dart';
import 'models/storage.dart';

class StorageItemService {
  static final StorageItemService _instance = StorageItemService._internal();

  StorageItemService._internal();

  factory StorageItemService() => _instance;

  Future<List<StorageItem>> getItems(
      int householdId, String storageName) async {
    var res = await kDio.post('/storageitems',
        data: {
          "id": householdId,
          "name": storageName,
        },
        options: Options(
          headers: {"Authorization": "Bearer ${UserService().token}"},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    print('getStorageItems');

    return storageItemFromJson(res.data as List);
  }

  Future<bool> addItem(StorageItem item) async {
    var res = await kDio.post('/storageitems/create',
        data: {
          "item_id": item.itemId,
          "household_id": item.householdId,
          "storage_name": item.storageName,
          "quantity": item.quantity,
          "unit": item.unit.id,
          "category": item.category.id,
        },
        options: Options(
          headers: {"Authorization": "Bearer ${UserService().token}"},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    print('addStorageItem');

    return res.statusCode == 201;
  }

  Future<bool> delete(StorageItem item) async {
    var res = await kDio.post('/storageitems/delete',
        data: {
          "item_id": item.itemId,
          "id": item.householdId,
          "name": item.storageName,
          "created_at": item.createdAt.toIso8601String(),
        },
        options: Options(
          headers: {"Authorization": "Bearer ${UserService().token}"},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    print('deleteStorageItem');

    return res.statusCode == 201 ||
        res.statusCode == 200 ||
        res.statusCode == 203;
  }
}
