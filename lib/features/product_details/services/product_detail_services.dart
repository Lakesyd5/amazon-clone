import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ProductDetailServices {
  void rateProduct({
    required WidgetRef ref,
    required Product product,
    required double rating,
  }) async {
    final user = ref.watch(userProvider);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth_token': user.token,
        },
        body: jsonEncode({
          'id': product.id,
          'rating': rating,
        }),
      );

      httpErrorHandle(
        response: res,
        onSuccess: () {
          print('Complete call from API');
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}