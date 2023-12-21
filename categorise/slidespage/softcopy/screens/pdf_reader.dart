import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_project_1st/categorise/slidespage/softcopy/models/document_model.dart';
import 'package:flutter_project_1st/categorise/slidespage/softcopy/widgets/FileDownloader.dart';
import 'package:http/http.dart';


class ReaderScreen extends StatefulWidget {
  final  Document document;
  ReaderScreen(this.document, {Key? key}) : super(key: key);

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late PDFViewController pdfController;
  int currentPage = 0;
  late String? pdfUrl;

  @override
  void initState() {
    super.initState();
    pdfUrl = widget.document.doc_url;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEAEAEA).withOpacity(.45),
        title: Text(widget.document.doc_title!),
        
        actions: [
          IconButton(
            icon: Icon(Icons.download), // Download icon
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DownloadingDialog(widget.document),
              );
            },
          ),
        ],
      ),
      body: Container(
        //child: SfPdfViewer.asset(pdfUrl!),
      ),
    );
  }
}