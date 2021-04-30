import 'package:flutter/material.dart';
import 'package:learn_computer_studies/pages/homepage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPdfPage extends StatefulWidget {
  static String id = 'viewPdfPageId';

  @override
  _ViewPdfPageState createState() => _ViewPdfPageState();
}

class _ViewPdfPageState extends State<ViewPdfPage> {
  PdfInfo pdfInfo;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   pdfInfo = ModalRoute.of(context)!.settings.arguments as PdfInfo;
    //   print(pdfInfo);
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    pdfInfo = ModalRoute.of(context).settings.arguments as PdfInfo;

    return Scaffold(
        appBar: AppBar(
          title: pdfInfo == null ? Text('') : Text(pdfInfo.pdfTitle),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Container(
            child: pdfInfo == null
                ? CircularProgressIndicator()
                : SfPdfViewer.asset(pdfInfo.filePath),
          ),
        ));
  }
}
