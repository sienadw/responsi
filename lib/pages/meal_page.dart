import 'package:flutter/material.dart';
import 'package:responsi_mobile_124220111/model/meal_model.dart';
import 'package:responsi_mobile_124220111/pages/meal_detail_page.dart';
import 'package:responsi_mobile_124220111/services/meal_service.dart';

class MealPage extends StatefulWidget {
  final String category;

  const MealPage({super.key, required this.category});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  final MealService _mealService = MealService();
  late Future<List<Meal>> _meals;

  @override
  void initState() {
    super.initState();
    _meals = _fetchMeals();
  }

  Future<List<Meal>> _fetchMeals() async {
    return await _mealService.getMealsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 222, 197),
      appBar: AppBar(
        iconTheme: const IconThemeData(
        color: Colors.white
        ),
        title: Text("Meals in ${widget.category}"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.brown,
      ),
      body: FutureBuilder<List<Meal>>(
        future: _meals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final meals = snapshot.data!;
            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealDetailPage(idMeal: meal.idMeal),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Image.network(
                          meal.strMealThumb,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              meal.strMeal,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                        const Padding(
                        padding: EdgeInsets.only(right: 8.0), // Memberikan jarak dari tepi kanan
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.brown,
                        ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No meals available."));
          }
        },
      ),
    );
  }
}
