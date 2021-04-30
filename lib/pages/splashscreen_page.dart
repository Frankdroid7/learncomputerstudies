import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_computer_studies/pages/check_verified_user_page.dart';
import 'package:learn_computer_studies/pages/homepage.dart';
import 'package:learn_computer_studies/pages/signup_page.dart';
import 'package:learn_computer_studies/services/firebase_service.dart';

class SplashScreenPage extends StatefulWidget {
  static String id = 'splashScreenPageId';

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 2), () {
        if (FirebaseService.user == null) {
          Navigator.pushReplacementNamed(context, SignUpPage.id);
        } else {
          Navigator.pushReplacementNamed(context, HomePage.id);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF008080),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 150,
                width: 150,
                child: Image.asset('assets/computer_icon.png')),
            Text(
              'Learn Computer Studies',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );

    // return StreamBuilder(
    //     stream: FirebaseService.auth.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return CircularProgressIndicator();
    //       }
    //       if (snapshot.hasError) {
    //         return Text('There was an error, please re-open the app.');
    //       }
    //       if (snapshot.data == null) {
    //         return SignUpPage();
    //       } else {
    //         return CheckVerifiedUser(snapshot.data as User);
    //       }
    //     });
  }
}
