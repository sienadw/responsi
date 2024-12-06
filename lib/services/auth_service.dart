// ignore_for_file: avoid_print, camel_case_types, file_names

import 'package:shared_preferences/shared_preferences.dart';

class authServices {
  static void simpanAkun(String username, String password) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    sharedPref.setString('username', username);
    sharedPref.setString('password', password);

    print(sharedPref.getString('username'));
    print(sharedPref.getString('password'));
  }

  static Future<bool> login(String username, String password) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    if (username == sharedPref.getString('username') &&
        password == sharedPref.getString('password')) {
      return true;
    }
    return false;
  }
}
