import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Product>> fetchSearchedProduct({
    required ref,
    required String serachQuery,
  }) async {
    final user = ref.watch(userProvider);
    List<Product> searchedProductsList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products/search/$serachQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth_token': user.token,
        },
      );

      httpErrorHandle(
        response: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            searchedProductsList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return searchedProductsList;
  }
}
