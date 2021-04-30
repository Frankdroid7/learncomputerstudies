import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helper {
  static displayError(BuildContext context, String content) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: Colors.red,
      duration: Duration(milliseconds: 2000),
    ));
  }
}
