import 'package:http/http.dart' as http;

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';

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
}
