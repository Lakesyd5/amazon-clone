import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required VoidCallback onSuccess,
}) {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    onSuccess();
  } else {
    switch (response.statusCode) {
      case 400:
        toastInfo(jsonDecode(response.body)['msg']);
        break;
      case 500:
        toastInfo(jsonDecode(response.body)['error']);
        break;
      default:
        toastInfo(response.body);
    }
  }
}
