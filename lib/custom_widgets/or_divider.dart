import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: Colors.black.withOpacity(.4),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or',
            style: TextStyle(
                color: Colors.black.withOpacity(.4),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.black.withOpacity(.4),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
