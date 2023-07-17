import 'package:dio/dio.dart';
import 'package:fridsch_app/bl/api/user.service.dart';

import 'connection.service.dart';
import 'models/storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();

  StorageService._internal();

  factory StorageService() => _instance;

  Future<List<Storage>> getStorages(int householdId) async {
    var res = await kDio.post('/storages',
        data: {"id": householdId},
        options: Options(
          headers: {"Authorization": "Bearer ${UserService().token}"},
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    print('getStorages');

    return storageFromJson(res.data as List);
  }

  Future<bool> create(Storage storage) async {
    var res = await kDio.post(
      '/storages/create',
      data: storage.toJson(),
      options: Options(
        headers: {"Authorization": "Bearer ${UserService().token}"},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    print('createStorage');

    return res.statusCode == 201;
  }

  Future<bool> delete(Storage storage) async {
    var res = await kDio.post(
      '/storages/delete',
      data: {
        "id": storage.householdId,
        "name": storage.name,
      },
      options: Options(
        headers: {"Authorization": "Bearer ${UserService().token}"},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    print('deleteStorage');

    return res.statusCode == 203;
  }

  Future<int> getLength(Storage storage) async {
    var res = await kDio.post(
      '/storages/length',
      data: {
        'household_id': storage.householdId,
        'name': storage.name,
      },
      options: Options(
        headers: {"Authorization": "Bearer ${UserService().token}"},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    print('getStorageLength');

    return res.data;
  }
}
