import 'package:dio/dio.dart';
import 'package:fridsch_app/bl/api/connection.service.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:fridsch_app/bl/api/models/category.dart';
import 'package:fridsch_app/bl/api/user.service.dart';

class CategoryService {
  static final CategoryService _instance = CategoryService._internal();

  CategoryService._internal();

  factory CategoryService() => _instance;

  Future<List<Category>> getCategories() async {
    var res = await kDio.post('/categories',
        data: {
          "id": HouseholdService().currentHousehold,
        },
        options: Options(headers: {
          "Authorization": "Bearer ${UserService().token}",
        }));

    print('getCategories');
    return categoryFromJson(res.data);
  }
}
