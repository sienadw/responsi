import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/category.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1/categories.php';

  Future<List<Category>> getCategories(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/$type/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

Future<List<Category>> getCategorieMeals(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/$type/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  Future<Category> getDetailMeals(String type, int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$type/$id/'));

    if (response.statusCode == 200) {
      return Category.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load article details');
    }
  }
}
