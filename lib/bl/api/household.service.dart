import 'package:dio/dio.dart';
import 'package:fridsch_app/bl/api/connection.service.dart';
import 'package:fridsch_app/bl/api/models/household.dart';
import 'package:fridsch_app/bl/api/user.service.dart';

class HouseholdService {
  static final HouseholdService _instance = HouseholdService._internal();

  int _currentHousehold = -1;

  HouseholdService._internal();

  factory HouseholdService() => _instance;

  int get currentHousehold => _currentHousehold;
  set currentHousehold(int current) => _currentHousehold = current;

  Future<List<Household>> getHouseholds() async {
    var res = await kDio.get('/households',
        options: Options(headers: {
          "Authorization": "Bearer ${UserService().token}",
        }));

    final households = householdFromJson(res.data);
    final adminHouseholds = await getHouseholdsWhereAdmin();

    for (Household h in households) {
      h.admin = adminHouseholds.any((element) => element.id == h.id);
    }
    print('getHouseholds');
    return households;
  }

  Future<List<Household>> getHouseholdsWhereAdmin() async {
    var res = await kDio.get('/households/findAllWhereAdmin',
        options: Options(headers: {
          "Authorization": "Bearer ${UserService().token}",
        }));

    print('getHouseholdsWhereAdmin');

    return householdFromJson(res.data);
  }

  Future<Household> addHousehold(String name, String emoji) async {
    var res = await kDio.post('/households/create',
        options: Options(headers: {
          "Authorization": "Bearer ${UserService().token}",
        }),
        data: {
          "name": name,
          "emoji": emoji,
        });

    print('addHousehold');

    return Household.fromJson(res.data);
  }

  Future<Household> updateHousehold(Household household) async {
    var res = await kDio.patch('/households/update/${household.id}',
        options: Options(headers: {
          "Authorization": "Bearer ${UserService().token}",
        }),
        data: {
          "name": household.name,
          "emoji": household.emoji,
        });

    print('updateHousehold');
    return Household.fromJson(res.data);
  }

  Future<bool> delete(Household household) async {
    var res = await kDio.delete(
      '/households/delete/${household.id}',
      options: Options(headers: {
        "Authorization": "Bearer ${UserService().token}",
      }),
    );

    print('deleteHousehold');
    return res.statusCode == 200;
  }

  Future<String> createToken() async {
    var res = await kDio.post(
      '/households/createtoken',
      data: {
        "household_id": currentHousehold,
      },
      options: Options(headers: {
        "Authorization": "Bearer ${UserService().token}",
      }),
    );

    print('createHouseholdToken');

    return res.data['token'];
  }

  Future<bool> join(String token) async {
    var res = await kDio.post(
      '/households/join',
      data: {
        "household_jwt": token,
      },
      options: Options(headers: {
        "Authorization": "Bearer ${UserService().token}",
      }),
    );

    print('joinHousehold');

    return res.data['success'];
  }
}
