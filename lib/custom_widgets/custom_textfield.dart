import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String errorText;
  String labelText;
  EdgeInsets margin;
  bool isPasswordField;
  Function(String value) onSave;
  Function validator;

  CustomTextField({
    this.onSave,
    this.labelText,
    this.validator,
    this.errorText,
    this.isPasswordField = false,
    this.margin = const EdgeInsets.symmetric(
      vertical: 8.0,
    ),
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: TextFormField(
        onSaved: widget.onSave,
        obscureText: widget.isPasswordField ? obscureText : false,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey,
            ),
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: obscureText
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                )
              : SizedBox.shrink(),
        ),
        validator: (value) {
          return widget.validator(value) ? null : widget.errorText;
        },
      ),
    );
  }
}
