import 'package:flutter/material.dart';
import 'package:responsi_mobile_124220111/model/category.dart';
//import 'package:responsi_mobile_124220111/pages/list_page.dart';
import 'package:responsi_mobile_124220111/services/api_service.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String password;

  final String category;

  const HomePage({super.key, required this.username, required this.password, required this.category});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  late Future<List<Categories>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = _apiService.getCategories(widget.category) as Future<List<Categories>>;
  }

  //void _navigateToList(BuildContext context, String type) {
    //Navigator.push(
      //context,
      //MaterialPageRoute(
        //builder: (context) => ListPage(category: category),
      //),
    //);
  //}
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class MenuButton extends StatefulWidget {
  final String strCategory;
  final String strCategoryDescription;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.strCategory,
    required this.strCategoryDescription,
    required this.onPressed, required title, required description,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  late final String strCategory;

  Future<Widget> (BuildContext context, dynamic category) async {
    return SizedBox(
      width: double.infinity,
      height: 145,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  category.strCategory,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
