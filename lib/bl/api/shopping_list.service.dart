import 'package:dio/dio.dart';
import 'package:fridsch_app/bl/api/connection.service.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:fridsch_app/bl/api/models/shopping_list.dart';
import 'package:fridsch_app/bl/api/user.service.dart';

class ShoppingListService {
  static final ShoppingListService _instance = ShoppingListService._internal();

  ShoppingListService._internal();

  factory ShoppingListService() => _instance;

  Future<List<ShoppingList>> getShoppingLists() async {
    var res = await kDio.post('/shoppinglists',
        data: {
          "id": HouseholdService().currentHousehold,
        },
        options: Options(headers: {
          "Authorization": "Bearer ${UserService().token}",
        }));

    print('getshoppingLists');

    return shoppingListFromJson(res.data);
  }

  Future<bool> create(ShoppingList list) async {
    var res = await kDio.post('/shoppinglists/create',
        data: {
          "household_id": HouseholdService().currentHousehold,
          "name": list.name,
          "emoji": list.emoji,
        },
        options: Options(headers: {
          "Authorization": "Bearer ${UserService().token}",
        }));

    print('createShoppingList');
    return res.statusCode == 201;
  }

  Future<int> getLength(ShoppingList list) async {
    var res = await kDio.post(
      '/shoppinglists/length',
      data: {
        'household_id': list.householdId,
        'name': list.name,
      },
      options: Options(
        headers: {"Authorization": "Bearer ${UserService().token}"},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    print('getShoppingListLength');

    return res.data;
  }

  Future<bool> finish(int household, String name, String saveToStorage) async {
    var res = await kDio.post(
      '/shoppinglists/finish',
      data: {
        "household_id": household,
        "name": name,
        "storage": saveToStorage,
      },
      options: Options(
        headers: {"Authorization": "Bearer ${UserService().token}"},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    print('finishShoppinng');

    return res.statusCode == 200 || res.statusCode == 201;
  }
}
