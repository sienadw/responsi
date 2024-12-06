import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/meal_detail_model.dart';

class MealDetailService {
  final String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/lookup.php';

  Future<MealDetail> getMealDetail(String idMeal) async {
    final response = await http.get(Uri.parse('$_baseUrl?i=$idMeal'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MealDetail.fromJson(data['meals'][0]);
    } else {
      throw Exception('Failed to load meal detail');
    }
  }
}
