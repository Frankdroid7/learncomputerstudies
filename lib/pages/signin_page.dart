import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learn_computer_studies/custom_widgets/action_button.dart';
import 'package:learn_computer_studies/custom_widgets/custom_textfield.dart';
import 'package:learn_computer_studies/pages/homepage.dart';
import 'package:learn_computer_studies/pages/verifyemail_page.dart';
import 'package:learn_computer_studies/services/firebase_service.dart';
import 'package:learn_computer_studies/utilities/helper.dart';

class SignInPage extends StatefulWidget {
  static String id = 'signInPageId';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = '';
  String password = '';
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Email Address',
                onSave: (value) => email = value,
                validator: (value) => value.isNotEmpty,
                errorText: 'Enter a valid email address',
              ),
              CustomTextField(
                labelText: 'Password',
                isPasswordField: true,
                errorText: 'Enter a valid password',
                onSave: (value) => password = value,
                validator: (value) => value.isNotEmpty,
              ),
              !isLoading
                  ? ActionButton(
                      label: 'Sign In',
                      onPressed: () async {
                        print(email);
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          setState(() => isLoading = true);

                          User user = await FirebaseService.signIn(
                            email: email,
                            password: password,
                          );
                          setState(() => isLoading = false);
                          if (user != null) {
                            if (user.emailVerified) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, HomePage.id, (route) => false);
                            } else {
                              Navigator.pushNamed(
                                context,
                                VerifyEmailPage.id,
                                arguments: user,
                              );
                            }
                          } else {
                            Helper.displayError(
                                context, FirebaseService.errorMsg);
                          }
                        }
                      },
                    )
                  : CircularProgressIndicator(),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account?  ',
                  style: TextStyle(color: Colors.black),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Sign up',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pop(context),
                      style: TextStyle(color: Colors.orange),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
