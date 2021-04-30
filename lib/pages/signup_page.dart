import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:learn_computer_studies/custom_widgets/action_button.dart';
import 'package:learn_computer_studies/custom_widgets/custom_textfield.dart';
import 'package:learn_computer_studies/custom_widgets/or_divider.dart';
import 'package:learn_computer_studies/model/user_model.dart';
import 'package:learn_computer_studies/pages/signin_page.dart';
import 'package:learn_computer_studies/pages/verifyemail_page.dart';
import 'package:learn_computer_studies/services/firebase_service.dart';
import 'package:learn_computer_studies/utilities/helper.dart';

class SignUpPage extends StatefulWidget {
  static String id = 'signUpPageId';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email = '';
  String password = '';
  String lastName = '';
  String firstName = '';
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 32),
                CustomTextField(
                  labelText: 'First Name',
                  errorText: 'Enter your first name',
                  onSave: (value) => firstName = value,
                  validator: (value) => value.isNotEmpty,
                ),
                CustomTextField(
                  labelText: 'Last Name',
                  errorText: 'Enter your last name',
                  onSave: (value) => lastName = value,
                  validator: (value) => value.isNotEmpty,
                ),
                CustomTextField(
                  labelText: 'Email Address',
                  onSave: (value) => email = value,
                  validator: (value) => value.isNotEmpty,
                  errorText: 'Enter a valid email address',
                ),
                CustomTextField(
                  labelText: 'Password',
                  isPasswordField: true,
                  onSave: (value) => password = value,
                  validator: (value) => value.length >= 8,
                  errorText: 'Password should not be less than 8 characters',
                ),
                !isLoading
                    ? ActionButton(
                        label: 'Sign Up',
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            setState(() => isLoading = true);
                            formKey.currentState.save();

                            User user = await FirebaseService.signUp(
                              email: email,
                              password: password,
                              lastName: lastName,
                              firstName: firstName,
                            );
                            setState(() => isLoading = false);
                            if (user == null) {
                              Helper.displayError(
                                  context, FirebaseService.errorMsg);
                            } else {
                              Navigator.pushReplacementNamed(
                                context,
                                VerifyEmailPage.id,
                                arguments: user,
                              );
                            }
                          }
                        },
                      )
                    : CircularProgressIndicator(),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account?  ',
                    style: TextStyle(color: Colors.black),
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Sign in',
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => Navigator.pushNamed(context, SignInPage.id),
                        style: TextStyle(color: Colors.orange),
                      )
                    ],
                  ),
                ),
                OrDivider(),
                SignInButton(
                  Buttons.Google,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
