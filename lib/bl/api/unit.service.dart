import 'package:dio/dio.dart';
import 'package:fridsch_app/bl/api/connection.service.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:fridsch_app/bl/api/models/category.dart';
import 'package:fridsch_app/bl/api/models/household.dart';
import 'package:fridsch_app/bl/api/models/unit.dart';
import 'package:fridsch_app/bl/api/user.service.dart';

class UnitService {
  static final UnitService _instance = UnitService._internal();

  UnitService._internal();

  factory UnitService() => _instance;

  Future<List<Unit>> getUnits() async {
    var res = await kDio.get('/units',
        options: Options(headers: {
          "Authorization": "Bearer ${UserService().token}",
        }));

    print('geUnits');

    return unitFromJson(res.data as List);
  }
}
