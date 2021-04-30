import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_computer_studies/pages/signup_page.dart';
import 'package:learn_computer_studies/pages/view_pdf_page.dart';
import 'package:learn_computer_studies/services/firebase_service.dart';

class HomePage extends StatefulWidget {
  static String id = 'homePageId';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userFirstName;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  getUserName() async {
    await FirebaseService.collectionReference.get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['email'] ==
            FirebaseAuth.instance.currentUser.email) {
          userFirstName = element.data()['firstName'];
        }
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          backgroundColor: Colors.teal,
          automaticallyImplyLeading: false,
          title: userFirstName == null
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                )
              : Text('Welcome, $userFirstName'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseService.signOut();
                  Navigator.pushReplacementNamed(context, SignUpPage.id);
                },
                child: Text('LOG OUT'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: pdfFiles.keys
                  .map((pdfTitle) => InkWell(
                        onTap: () {
                          // getFileFromAsset(pdfFiles[e]!).then((f) {
                          //   assetPDFPath = f.path;
                          //   print('assetPDFPath: $assetPDFPath');
                          // });
                          Navigator.pushNamed(
                            context,
                            ViewPdfPage.id,
                            arguments: PdfInfo(
                              pdfTitle: pdfTitle,
                              filePath: pdfFiles[pdfTitle],
                            ),
                          );
                        },
                        child: Card(
                          child: Center(
                            child: Text(
                              pdfTitle,
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList()),
        ));
  }
}

Map<String, String> pdfFiles = {
  'JSS1 NOTE': 'assets/pdf_files/jss1_note.pdf',
  'JSS2 NOTE': 'assets/pdf_files/jss2_note.pdf',
  'JSS3 NOTE': 'assets/pdf_files/jss3_note.pdf',
  'SS1 NOTE': 'assets/pdf_files/ss1_note.pdf',
  'SS2 NOTE': 'assets/pdf_files/ss2_note1.pdf',
  'SS3 NOTE': 'assets/pdf_files/ss3_note.pdf',
};

class PdfInfo {
  String pdfTitle;
  String filePath;

  PdfInfo({this.pdfTitle, this.filePath});
}
