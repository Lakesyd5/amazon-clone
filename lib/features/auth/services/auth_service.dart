import 'dart:convert';

import 'package:amazon_clone/provider/user_provider.dart';
import 'package:http/http.dart' as http;

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Sign up user
  void signUpUser({
    required name,
    required email,
    required password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response response = await http.post(
        Uri.parse('$uri/amazon-api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: response,
        onSuccess: () {
          toastInfo('Account Created, Login with same details');
        },
      );
    } catch (e) {
      toastInfo(e.toString());
    }
  }

  // Sign In user
  void signInUser({
    required ref,
    required email,
    required password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/amazon-api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: response,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          ref.read(userProvider.notifier).setUser(response.body);
          await prefs.setString(
            'auth_token',
            jsonDecode(response.body)['token'],
          );
          toastInfo('You are now signed in');
        },
      );
    } catch (e) {
      toastInfo(e.toString());
    }
  }

  //  Get userData
  void getUserData(
    ref,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        prefs.setString('auth_token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'auth_token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8',
            'auth_token': token,
          },
        );

        ref.read(userProvider.notifier).setUser(userRes.body);
      }
    } catch (e) {
      toastInfo(e.toString());
    }
  }
}
