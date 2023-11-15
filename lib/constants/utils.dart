import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:amazon_clone/constants/global_variable.dart';

toastInfo(String msg, {
  Color backgroundColor = GlobalVariables.secondaryColor, Color textColor = GlobalVariables.backgroundColor,
}) {
  return Fluttertoast.showToast(msg: msg,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.TOP,
  timeInSecForIosWeb: 2,
  backgroundColor: backgroundColor,
  textColor: textColor,
  fontSize: 16
  );
}