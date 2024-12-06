class MealDetail {
  final String idMeal;
  final String strMeal;
  final String strInstructions;
  final String strMealThumb;
  final String strYoutube;
  final String strCategory;
  final String strArea;
  final List<String> ingredients;

  MealDetail({
    required this.idMeal,
    required this.strMeal,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strYoutube,
    required this.strCategory,
    required this.strArea,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add('$measure $ingredient');
      }
    }

    return MealDetail(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strYoutube: json['strYoutube'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      ingredients: ingredients,
    );
  }
}
