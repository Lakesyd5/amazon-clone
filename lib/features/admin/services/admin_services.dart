import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/router.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required ref,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = ref.watch(userProvider);

    try {
      final cloudinary = CloudinaryPublic('dxn95c68z', 'hxdrykn7');
      List<String> imageUrls = [];

      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );

        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'auth_token': user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
        response: response,
        onSuccess: () {
          toastInfo('Product Added Successfully!');
          ref.read(routerProvider).pop();
        },
      );
    } catch (e) {
      toastInfo(e.toString());
    }
  }

  // fetchAllProducts
  Future<List<Product>> fetchAllProducts(ref) async {
    final user = ref.read(userProvider);
    List<Product> productsList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'auth_token': user.token,
        },
      );

      httpErrorHandle(
        response: response,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(response.body).length; i++) {
            productsList.add(
              Product.fromJson(
                jsonEncode(jsonDecode(response.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      toastInfo(e.toString());
    }

    return productsList;
  }

  // Delete product 
  void deleteProduct({
    required ref,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final user = ref.wathc(userProvider);

    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'auth_token': user.token,
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErrorHandle(
        response: response,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      toastInfo(e.toString());
    }
  }
}
