import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/meal_model.dart';

class MealService {
  final String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/filter.php';

  Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await http.get(Uri.parse('$_baseUrl?c=$category'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List meals = data['meals'];
      return meals.map((e) => Meal.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
