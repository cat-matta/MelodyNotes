import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:melodyscore/data/drift_db.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFPage extends StatefulWidget {
  const PDFPage({
    Key? key,
    required this.score,
  }) : super(key: key);
  final Score score;

  @override
  State<PDFPage> createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.landscape)
        return KeyboardListener(
          child: SfPdfViewer.file(File(widget.score.file),
              controller: _pdfViewerController),
          focusNode: FocusNode(),
          onKeyEvent: (value) {
            if (value.logicalKey == LogicalKeyboardKey.arrowRight) {
              _pdfViewerController.nextPage();
            } else if (value.logicalKey == LogicalKeyboardKey.arrowLeft) {
              _pdfViewerController.previousPage();
            }
            setState(() {});
          },
        );
      else
        return KeyboardListener(
          child: SfPdfViewer.file(File(widget.score.file),
              pageLayoutMode: PdfPageLayoutMode.single,
              controller: _pdfViewerController),
          focusNode: FocusNode(),
          onKeyEvent: (value) {
            if (value.logicalKey == LogicalKeyboardKey.arrowRight) {
              _pdfViewerController.nextPage();
            } else if (value.logicalKey == LogicalKeyboardKey.arrowLeft) {
              _pdfViewerController.previousPage();
            }
            setState(() {});
          },
        );
    });
  }
}
