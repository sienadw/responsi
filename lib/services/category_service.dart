import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi_mobile_124220111/model/category_model.dart';

class CategoryService {
  final String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/categories.php';

  Future<List<Category>> getMealCategories() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List categories = data['categories'];
      return categories.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
