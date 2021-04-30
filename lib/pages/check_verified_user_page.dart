import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_computer_studies/pages/homepage.dart';
import 'package:learn_computer_studies/pages/verifyemail_page.dart';

class CheckVerifiedUser extends StatefulWidget {
  final User user;
  CheckVerifiedUser(this.user);

  @override
  _CheckVerifiedUserState createState() => _CheckVerifiedUserState();
}

class _CheckVerifiedUserState extends State<CheckVerifiedUser> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.user.emailVerified) {
        Navigator.pushReplacementNamed(context, HomePage.id);
      } else {
        Navigator.pushReplacementNamed(
          context,
          VerifyEmailPage.id,
          arguments: widget.user,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
