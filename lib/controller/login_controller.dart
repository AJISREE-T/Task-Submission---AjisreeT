import 'package:flutter/material.dart';

import 'package:productapp/api/api_calls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  Future<Map> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty) {
        return {'status': 'false', 'msg': 'email cannot be empty'};
      } else if (password.isEmpty) {
        return {'status': 'false', 'msg': ' password cannot be empty'};
      } else {
        var data = await ApiCalls.loginUser(
          email: email.trim(),
          password: password.trim(),
        );
        if (data['status'] == 'true') {
          return {
            'status': 'true',
            'message': 'Login successful',
            'data': data
          };
        } else {
          return {'status': 'false', 'message': 'Invalid username or password'};
        }
      }
    } catch (e) {
      // log(e.toString());
      return {'status': 'false'};
    }
  }

  Future<void> _saveLoginDetails(
      {required String email, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password',
        password); // Store password (not recommended for production)
  }

  // Method to get stored login details from SharedPreferences
  Future<Map<String, String?>> getLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    return {'email': email, 'password': password};
  }

  // Method to clear login details from SharedPreferences (for logout)
  Future<void> clearLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('password');
  }
}
