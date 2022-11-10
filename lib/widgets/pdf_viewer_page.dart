import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class PdfViewerPage extends StatefulWidget {
  final String? file;
  // final String url;

  const PdfViewerPage({
    Key? key,
    required this.file,
    // required this.url,
  }) : super(key: key);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file!);
    return Container(
      child: PDFView(
        filePath: widget.file!,
      ),
    );
  }
}
