import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn_computer_studies/pages/splashscreen_page.dart';
import 'package:learn_computer_studies/pages/homepage.dart';
import 'package:learn_computer_studies/pages/signin_page.dart';
import 'package:learn_computer_studies/pages/signup_page.dart';
import 'package:learn_computer_studies/pages/verifyemail_page.dart';
import 'package:learn_computer_studies/pages/view_pdf_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();
  runApp(FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong. Re-open the app');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }
        return MaterialApp(
            home: Scaffold(
                backgroundColor: Color(0XFF008080),
                body: Center(child: CircularProgressIndicator())));
      }));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreenPage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        SignUpPage.id: (context) => SignUpPage(),
        SignInPage.id: (context) => SignInPage(),
        ViewPdfPage.id: (context) => ViewPdfPage(),
        VerifyEmailPage.id: (context) => VerifyEmailPage(),
        SplashScreenPage.id: (context) => SplashScreenPage(),
      },
    );
  }
}
