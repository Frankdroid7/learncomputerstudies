import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  String label;
  Function() onPressed;

  ActionButton({
    @required this.label,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
