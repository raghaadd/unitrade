import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String pdfFilePath;

  PdfPreviewScreen({required this.pdfFilePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PDFView(
        filePath: 'file:$pdfFilePath',
        onRender: (_pages) {
          // Do something when the PDF is rendered.
          print("PDF is rendered with $_pages pages!");
        },
        onError: (error) {
          // Handle error during PDF loading.
          print(error);
        },
        onPageError: (page, error) {
          // Handle error during page loading.
          print('Error while loading page $page: $error');
        },
      ),
    );
  }
}
