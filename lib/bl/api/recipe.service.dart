import 'package:dio/dio.dart';
import 'package:fridsch_app/bl/api/connection.service.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:fridsch_app/bl/api/models/recipe.dart';
import 'package:fridsch_app/bl/api/user.service.dart';

class RecipeyService {
  static final RecipeyService _instance = RecipeyService._internal();

  RecipeyService._internal();

  factory RecipeyService() => _instance;

  Future<List<Recipe>> getRecipes() async {
    var res = await kDio.post('/recipes',
        data: {
          "id": HouseholdService().currentHousehold,
        },
        options: Options(headers: {
          "Authorization": "Bearer ${UserService().token}",
        }));

    print('getCategories');
    return recipeFromJson(res.data);
  }
}
