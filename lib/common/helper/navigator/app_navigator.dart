import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppNavigator {
  static void pushReplacement({
    required BuildContext context,
    required Widget widget,
  }) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (c) => widget),
    );
  }

  static void push({required BuildContext context, required Widget widget}) {
    Navigator.push(context, MaterialPageRoute(builder: (c) => widget));
  }
}
