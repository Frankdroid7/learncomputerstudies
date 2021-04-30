import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_computer_studies/pages/homepage.dart';
import 'package:learn_computer_studies/services/firebase_service.dart';
import 'package:learn_computer_studies/utilities/helper.dart';
import 'package:learn_computer_studies/utilities/lifecycle_event_handler.dart';

class VerifyEmailPage extends StatefulWidget {
  static String id = 'verifyEmailPageId';

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  User user;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      user = ModalRoute.of(context).settings.arguments as User;
      user.sendEmailVerification();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user == null
                    ? ''
                    : 'Email has been sent to ${user.email} for verification.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email verified? ---->',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () async {
                      await user.reload();
                      /* FirebaseAuth.instance.currentUser is used here to get the
                      * very latest firebase user after the user have been reloaded.*/
                      if (FirebaseAuth.instance.currentUser.emailVerified) {
                        Navigator.pushReplacementNamed(context, HomePage.id);
                      } else {
                        Helper.displayError(context, 'Verify your email.');
                      }
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
