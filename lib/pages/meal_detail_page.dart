import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import '../model/meal_detail_model.dart';
import '../services/meal_detail_service.dart';

class MealDetailPage extends StatefulWidget {
  final String idMeal;

  const MealDetailPage({super.key, required this.idMeal});

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  final MealDetailService _mealDetailService = MealDetailService();
  late Future<MealDetail> _mealDetail;

  @override
  void initState() {
    super.initState();
    _mealDetail = _mealDetailService.getMealDetail(widget.idMeal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 222, 197),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Meal Detail"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.brown,
      ),
      body: Stack(
        children: [
          FutureBuilder<MealDetail>(
            future: _mealDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (snapshot.hasData) {
                final meal = snapshot.data!;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              meal.strMealThumb,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meal.strMeal,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  "Category: ${meal.strCategory}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  "Area: ${meal.strArea}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        "Ingredients",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8.0),
                      ...meal.ingredients.map((ingredient) {
                        return Text(
                          "- $ingredient",
                          style: Theme.of(context).textTheme.bodyMedium,
                        );
                      }),
                      const SizedBox(height: 16.0),
                      Text(
                        "Instructions",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        meal.strInstructions,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text("Meal not found."));
              }
            },
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: FutureBuilder<MealDetail>(
              future: _mealDetail,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data!.strYoutube.isNotEmpty) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchURL(snapshot.data!.strYoutube),
                      icon: const Icon(Icons.video_collection, color: Colors.white),
                      label: const Text(
                        "Watch Tutorial",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}
