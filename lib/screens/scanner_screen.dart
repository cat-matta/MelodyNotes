import 'dart:io';
import 'package:flutter/material.dart';
import '../themedata.dart';

import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class ScannerScreen extends StatefulWidget {
  static const routeName = '/scan-screen';
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  PDFDocument? _scannedDocument;
  File? _scannedDocumentFile;
  File? _scannedImage;
  openPdfScanner(BuildContext context) async {
    var doc = await DocumentScannerFlutter.launchForPdf(
      context,
      labelsConfig: {
        ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Steps",
        ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_SINGLE: "Only 1 Page",
        ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_MULTIPLE:
            "Only {PAGES_COUNT} Page"
      },
      //source: ScannerFileSource.CAMERA
    );
    if (doc != null) {
      _scannedDocument = null;
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 100));
      _scannedDocumentFile = doc;
      _scannedDocument = await PDFDocument.fromFile(doc);
      setState(() {});
    }
  }

  openImageScanner(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(context,
        //source: ScannerFileSource.CAMERA,
        labelsConfig: {
          ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Step",
          ScannerLabelsConfig.ANDROID_OK_LABEL: "OK"
        });
    if (image != null) {
      _scannedImage = image;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            titleSpacing: 2.3,
            backgroundColor: const Color.fromRGBO(44, 44, 60, 1),
            actionsIconTheme:
                const IconThemeData(color: Colors.green, size: 36),
            title: Container(
              
                alignment: Alignment.center,
                width: mediaQuerry.size.width * 0.4,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 186, 222, 204),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    IconButton(
                      onPressed: () => openPdfScanner(context),
                      icon: const Icon(Icons.file_copy_outlined),
                      color: Color.fromRGBO(4, 67, 171, 1),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => openImageScanner(context),
                      icon: const Icon(Icons.camera_alt_outlined),
                      color: Color.fromRGBO(4, 67, 171, 1),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.photo_library_outlined),
                      color: Color.fromRGBO(4, 67, 171, 1),
                    ),
                    const Spacer(),
                  ],
                )),
            leadingWidth: mediaQuerry.size.width,
            leading: Row(
              children: [
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text('Close'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(44, 44, 60, 1)),
                    )),
                const Spacer(),
                const Spacer(),
              ],
            ),
            actions: [
              Row(
                children: [
                  
                  ElevatedButton(
                      onPressed: () {},
                      child: Text('Save'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(44, 44, 60, 1), 
                            ),  )),
                ],
              )
            ]),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_scannedDocument != null || _scannedImage != null) ...[
              if (_scannedImage != null)
                Image.file(_scannedImage!,
                    width: 300, height: 300, fit: BoxFit.contain),
              if (_scannedDocument != null)
                Expanded(
                    child: PDFViewer(
                  document: _scannedDocument!,
                )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    _scannedDocumentFile?.path ?? _scannedImage?.path ?? ''),
              ),
            ],
            // Center(
            //   child: Builder(builder: (context) {
            //     return ElevatedButton(
            //         onPressed: () => openPdfScanner(context),
            //         child: const Text("PDF Scan"));
            //   }),
            // ),
            // Center(
            //   child: Builder(builder: (context) {
            //     return ElevatedButton(
            //         onPressed: () => openImageScanner(context),
            //         child: const Text("Image Scan"));
            //   }),
            // )
          ],
        ),
      ),
    );
  }
}
