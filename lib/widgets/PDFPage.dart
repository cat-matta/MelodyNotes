import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:melodyscore/data/drift_db.dart';
import 'package:melodyscore/themedata.dart';
import 'package:resizable_widget/resizable_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFPage extends StatefulWidget {
  const PDFPage({Key? key, required this.score, required this.halfPage})
      : super(key: key);
  final Score score;
  final bool halfPage;

  @override
  State<PDFPage> createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  late PdfViewerController _pdfViewerController;
  late PdfViewerController _pdfViewerControllerSecondary;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _pdfViewerControllerSecondary = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.landscape)
        return KeyboardListener(
          child: SfPdfViewer.file(File(widget.score.file),
              enableDoubleTapZooming: false, controller: _pdfViewerController),
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
      else {
        return KeyboardListener(
          child: widget.halfPage
              ? ResizableWidget(
                  isDisabledSmartHide: true,
                  isHorizontalSeparator: true,
                  separatorSize: 2.0,
                  separatorColor: AppTheme.accentMain,
                  children: [
                    SfPdfViewer.file(File(widget.score.file),
                        pageLayoutMode: PdfPageLayoutMode.continuous,
                        initialScrollOffset: Offset(0, 0),
                        initialZoomLevel: 1, onPageChanged: (details) {
                      setState(() {
                        print(_pdfViewerController.scrollOffset);
                      });
                    },
                        enableDoubleTapZooming: false,
                        controller: _pdfViewerController),
                    SfPdfViewer.file(File(widget.score.file),
                        // initialZoomLevel: 10,
                        initialScrollOffset: Offset(0, 500),
                        onPageChanged: (details) {
                      setState(() {
                        print("SECOND");
                        print(_pdfViewerControllerSecondary.scrollOffset);
                      });
                      // print(details);
                    },
                        pageLayoutMode: PdfPageLayoutMode.continuous,
                        enableDoubleTapZooming: false,
                        controller: _pdfViewerControllerSecondary),
                  ],
                )
              : SfPdfViewer.file(File(widget.score.file),
                  pageLayoutMode: PdfPageLayoutMode.single,
                  enableDoubleTapZooming: false,
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
      }
    });
  }
}
