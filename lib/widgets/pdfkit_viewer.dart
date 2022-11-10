import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:musescore/utils/file_utils.dart';
import 'package:musescore/utils/platform_utils.dart';

import 'package:pspdfkit_flutter/pspdfkit.dart';
import 'package:pspdfkit_flutter/widgets/pspdfkit_widget_controller.dart';
import 'package:pspdfkit_flutter/widgets/pspdfkit_widget.dart';
import 'pspdfkit_annotations_example.dart';

const String _documentPath =
    '/Users/cat/Library/Developer/CoreSimulator/Devices/8DCC97E8-8159-484C-8E7E-2C453917A97F/data/Containers/Data/Application/E7881F91-D35A-4C81-AC63-D9C84E539241/tmp/com.example.melodyscore-Inbox/IMSLP453230-PMLP07086-chaminadepianosonataincminorcompletet.pdf';

const String _pspdfkitFlutterPluginTitle =
    'PSPDFKit Flutter Plugin example app';

const String _basicExample = 'Basic Example';
const String _basicPlatformStyleExample = 'Basic Example using Platform Style';
const String _basicExampleSub = 'Opens a PDF Document.';
const String _basicPlatformStyleExampleSub =
    'Opens a PDF Document using Material page scaffolding for Android, and Cupertino page scaffolding for iOS.';

const String _customConfiguration = 'Custom configuration options';
const String _customConfigurationSub =
    'Opens a document with custom configuration options.';
const String _passwordProtectedDocument =
    'Opens and unlocks a password protected document';
const String _passwordProtectedDocumentSub =
    'Programmatically unlocks a password protected document.';

const String _formExample = 'Programmatic Form Filling Example';
const String _formExampleSub =
    'Programmatically sets and gets the value of a form field using a custom Widget.';
const String _annotationsExample =
    'Programmatically Adds and Removes Annotations';
const String _pdfGenerationExample = 'PDF generation';
const String _pdfGenerationExampleSub =
    'Programmatically generate PDFs from images, templates, and HTML.';
const String _annotationsExampleSub =
    'Programmatically adds and removes annotations using a custom Widget.';
const String _manualSaveExample = 'Manual Save';
const String _saveAsExample = 'Save As';
const String _manualSaveExampleSub =
    'Add a save button at the bottom and disable automatic saving.';
const String _saveAsExampleSub =
    'Embed and save the changes made to a document into a new file';
const String _annotationProcessingExample = 'Process Annotations';
const String _annotationProcessingExampleSub =
    'Programmatically adds and removes annotations using a custom Widget.';
const String _importInstantJsonExample = 'Import Instant Document JSON';
const String _importInstantJsonExampleSub =
    'Shows how to programmatically import Instant Document JSON using a custom Widget.';
const String _widgetExampleFullScreen =
    'Shows two PSPDFKit Widgets simultaneously';
const String _widgetExampleFullScreenSub =
    'Opens two different PDF documents simultaneously using two PSPDFKit Widgets.';

const String _basicExampleGlobal = 'Basic Example';
const String _basicExampleGlobalSub = 'Opens a PDF Document.';
const String _imageDocumentGlobal = 'Image Document';
const String _imageDocumentGlobalSub = 'Opens an image document.';
const String _darkThemeGlobal = 'Dark Theme';
const String _darkThemeGlobalSub =
    'Opens a document in night mode with custom dark theme.';
const String _customConfigurationGlobal = 'Custom configuration options';
const String _customConfigurationGlobalSub =
    'Opens a document with custom configuration options.';
const String _passwordProtectedDocumentGlobal =
    'Opens and unlocks a password protected document';
const String _passwordProtectedDocumentGlobalSub =
    'Programmatically unlocks a password protected document.';
const String _formExampleGlobal = 'Programmatic Form Filling Example';
const String _formExampleGlobalSub =
    'Programmatically set and get the value of a form field.';
const String _importInstantJsonExampleGlobal = 'Import Instant Document JSON';
const String _importInstantJsonExampleGlobalSub =
    'Shows how to programmatically import Instant Document JSON.';
const String _pspdfkitWidgetExamples = 'PSPDFKit Widget Examples';
const String _pspdfkitGlobalPluginExamples = 'PSPDFKit Modal View Examples';

const String _pspdfkitFor = 'PSPDFKit for';
const double _fontSize = 18.0;

class PDFPage extends StatefulWidget {
  final String documentPath;
  const PDFPage({Key? key, required this.documentPath}) : super(key: key);

  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> with WidgetsBindingObserver {
  static final ThemeData lightTheme = ThemeData(
      backgroundColor: Colors.transparent,
      primaryColor: Colors.black,
      dividerColor: Colors.grey[400]);

  static final ThemeData darkTheme = ThemeData(
      backgroundColor: Colors.transparent,
      primaryColor: Colors.white,
      dividerColor: Colors.grey[800]);
  String _frameworkVersion = '';
  ThemeData currentTheme = lightTheme;

  void showDocument() async {
    final extractedDocument = await extractAsset(context, widget.documentPath);
    await Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
        builder: (_) => Scaffold(
            extendBodyBehindAppBar: PlatformUtils.isAndroid(),
            // Do not resize the the document view on Android or
            // it won't be rendered correctly when filling forms.
            resizeToAvoidBottomInset: PlatformUtils.isIOS(),
            appBar: AppBar(),
            body: SafeArea(
                top: false,
                bottom: false,
                child: Container(
                    padding: PlatformUtils.isCupertino(context)
                        ? null
                        : const EdgeInsets.only(top: kToolbarHeight),
                    child: PspdfkitWidget(
                        documentPath: extractedDocument.path))))));
  }

  void showDocumentPlatformStyle() async {
    final extractedDocument = await extractAsset(context, widget.documentPath);

    if (PlatformUtils.isCupertino(context)) {
      await Navigator.of(context).push<dynamic>(CupertinoPageRoute<dynamic>(
          builder: (_) => CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(),
              child: SafeArea(
                  bottom: false,
                  child:
                      PspdfkitWidget(documentPath: extractedDocument.path)))));
    } else {
      await Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(),
              body: SafeArea(
                  top: false,
                  bottom: false,
                  child: Container(
                      padding: const EdgeInsets.only(top: kToolbarHeight),
                      child: PspdfkitWidget(
                          documentPath: extractedDocument.path))))));
    }
  }

  void applyCustomConfiguration() async {
    final extractedDocument = await extractAsset(context, widget.documentPath);
    await Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
        builder: (_) => Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar:
                PlatformUtils.isCupertino(context) ? false : true,
            appBar: AppBar(),
            body: SafeArea(
                top: false,
                bottom: false,
                child: Container(
                    padding: PlatformUtils.isCupertino(context)
                        ? null
                        : const EdgeInsets.only(top: kToolbarHeight),
                    child: PspdfkitWidget(
                        documentPath: extractedDocument.path,
                        configuration: const {
                          scrollDirection: 'vertical',
                          pageTransition: 'scrollContinuous',
                          spreadFitting: 'fit',
                          immersiveMode: false,
                          userInterfaceViewMode: 'automaticBorderPages',
                          androidShowSearchAction: true,
                          inlineSearch: false,
                          showThumbnailBar: 'floating',
                          androidShowThumbnailGridAction: true,
                          androidShowOutlineAction: true,
                          androidShowAnnotationListAction: true,
                          showPageLabels: true,
                          documentLabelEnabled: false,
                          invertColors: false,
                          androidGrayScale: false,
                          startPage: 2,
                          enableAnnotationEditing: true,
                          enableTextSelection: false,
                          androidShowBookmarksAction: false,
                          androidEnableDocumentEditor: false,
                          androidShowShareAction: true,
                          androidShowPrintAction: false,
                          androidShowDocumentInfoView: true,
                          appearanceMode: 'default',
                          androidDefaultThemeResource: 'PSPDFKit.Theme.Example',
                          iOSRightBarButtonItems: [
                            'thumbnailsButtonItem',
                            'activityButtonItem',
                            'searchButtonItem',
                            'annotationButtonItem'
                          ],
                          iOSLeftBarButtonItems: ['settingsButtonItem'],
                          iOSAllowToolbarTitleChange: false,
                          toolbarTitle: 'Custom Title',
                          settingsMenuItems: [
                            'pageTransition',
                            'scrollDirection',
                            'androidTheme',
                            'iOSAppearance',
                            'androidPageLayout',
                            'iOSPageMode',
                            'iOSSpreadFitting',
                            'androidScreenAwake',
                            'iOSBrightness'
                          ],
                          showActionNavigationButtons: false,
                          pageMode: 'double',
                          firstPageAlwaysSingle: true
                        }))))));
  }

  void annotationsExample() async {
    final extractedDocument = await extractAsset(context, widget.documentPath);
    await Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
        builder: (_) => PspdfkitAnnotationsExampleWidget(
            documentPath: extractedDocument.path)));
  }

  void onWidgetCreated(PspdfkitWidgetController view) async {
    try {
      await view.setFormFieldValue('Lastname', 'Name_Last');
      await view.setFormFieldValue('0123456789', 'Telephone_Home');
      await view.setFormFieldValue('City', 'City');
      await view.setFormFieldValue('selected', 'Sex.0');
      await view.setFormFieldValue('deselected', 'Sex.1');
      await view.setFormFieldValue('selected', 'HIGH SCHOOL DIPLOMA');
    } on PlatformException catch (e) {
      print("Failed to set form field values '${e.message}'.");
    }

    String? lastName;
    try {
      lastName = await view.getFormFieldValue('Name_Last');
    } on PlatformException catch (e) {
      print("Failed to get form field value '${e.message}'.");
    }

    if (lastName != null) {
      print(
          "Retrieved form field for fully qualified name 'Name_Last' is $lastName.");
    }
  }

  void showDocumentGlobal() async {
    final extractedDocument = await extractAsset(context, widget.documentPath);
    await Pspdfkit.present(extractedDocument.path);
  }

  void applyDarkThemeGlobal() async {
    final extractedDocument = await extractAsset(context, widget.documentPath);
    await Pspdfkit.present(extractedDocument.path, {
      appearanceMode: 'night',
      androidDarkThemeResource: 'PSPDFKit.Theme.Example.Dark'
    });
  }

  void applyCustomConfigurationGlobal() async {
    final extractedDocument = await extractAsset(context, widget.documentPath);
    await Pspdfkit.present(extractedDocument.path, {
      scrollDirection: 'vertical',
      pageTransition: 'scrollPerSpread',
      spreadFitting: 'fit',
      immersiveMode: false,
      userInterfaceViewMode: 'automaticBorderPages',
      androidShowSearchAction: true,
      inlineSearch: false,
      showThumbnailBar: 'floating',
      androidShowThumbnailGridAction: true,
      androidShowOutlineAction: true,
      androidShowAnnotationListAction: true,
      showPageLabels: true,
      documentLabelEnabled: false,
      invertColors: false,
      androidGrayScale: false,
      startPage: 2,
      enableAnnotationEditing: true,
      enableTextSelection: false,
      androidShowBookmarksAction: false,
      androidEnableDocumentEditor: false,
      androidShowShareAction: true,
      androidShowPrintAction: false,
      androidShowDocumentInfoView: true,
      appearanceMode: 'default',
      androidDefaultThemeResource: 'PSPDFKit.Theme.Example',
      iOSRightBarButtonItems: [
        'thumbnailsButtonItem',
        'activityButtonItem',
        'searchButtonItem',
        'annotationButtonItem'
      ],
      iOSLeftBarButtonItems: ['settingsButtonItem'],
      iOSAllowToolbarTitleChange: false,
      toolbarTitle: 'Custom Title',
      settingsMenuItems: [
        'pageTransition',
        'scrollDirection',
        'androidTheme',
        'iOSAppearance',
        'androidPageLayout',
        'iOSPageMode',
        'iOSSpreadFitting',
        'androidScreenAwake',
        'iOSBrightness'
      ],
      showActionNavigationButtons: false,
      pageMode: 'double',
      firstPageAlwaysSingle: true
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlatformState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    currentTheme =
        WidgetsBinding.instance.window.platformBrightness == Brightness.light
            ? lightTheme
            : darkTheme;
    setState(() {
      build(context);
    });
    super.didChangePlatformBrightness();
  }

  String frameworkVersion() {
    return '$_pspdfkitFor $_frameworkVersion\n';
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void initPlatformState() async {
    String? frameworkVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      frameworkVersion = await Pspdfkit.frameworkVersion;
    } on PlatformException {
      frameworkVersion = 'Failed to get platform version. ';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _frameworkVersion = frameworkVersion ?? '';
    });

    // By default, this example doesn't set a license key, but instead runs in
    // trial mode (which is the default, and which requires no specific
    // initialization). If you want to use a different license key for
    // evaluation (e.g. a production license), you can uncomment the next line
    // and set the license key.
    //
    // To set the license key for both platforms, use:
    // await Pspdfkit.setLicenseKeys("YOUR_FLUTTER_ANDROID_LICENSE_KEY_GOES_HERE",
    // "YOUR_FLUTTER_IOS_LICENSE_KEY_GOES_HERE");
    //
    // To set the license key for the currently running platform, use:
    // await Pspdfkit.setLicenseKey("YOUR_FLUTTER_LICENSE_KEY_GOES_HERE");
  }

  void flutterPdfActivityOnPauseHandler() {
    print('flutterPdfActivityOnPauseHandler');
  }

  void pdfViewControllerWillDismissHandler() {
    print('pdfViewControllerWillDismissHandler');
  }

  void pdfViewControllerDidDismissHandler() {
    print('pdfViewControllerDidDismissHandler');
  }

  @override
  Widget build(BuildContext context) {
    Pspdfkit.flutterPdfActivityOnPause =
        () => flutterPdfActivityOnPauseHandler();
    Pspdfkit.pdfViewControllerWillDismiss =
        () => pdfViewControllerWillDismissHandler();
    Pspdfkit.pdfViewControllerDidDismiss =
        () => pdfViewControllerDidDismissHandler();

    currentTheme = MediaQuery.of(context).platformBrightness == Brightness.light
        ? lightTheme
        : darkTheme;

    final listTiles = <Widget>[
      Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Text(_pspdfkitWidgetExamples,
              style: currentTheme.textTheme.headline4?.copyWith(
                  fontSize: _fontSize, fontWeight: FontWeight.bold))),
      ListTile(
          title: const Text(_basicExample),
          subtitle: const Text(_basicExampleSub),
          onTap: () => showDocument()),

      ListTile(
          title: const Text(_customConfiguration),
          subtitle: const Text(_customConfigurationSub),
          onTap: () => applyCustomConfiguration()),

      // The push two PspdfWidgets simultaneously example is supported by iOS only for now.
      ListTile(
          title: const Text(_basicPlatformStyleExample),
          subtitle: const Text(_basicPlatformStyleExampleSub),
          onTap: () => showDocumentPlatformStyle()),

      Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Text(_pspdfkitGlobalPluginExamples,
              style: currentTheme.textTheme.headline4?.copyWith(
                  fontSize: _fontSize, fontWeight: FontWeight.bold))),
      ListTile(
          title: const Text(_basicExampleGlobal),
          subtitle: const Text(_basicExampleGlobalSub),
          onTap: () => showDocumentGlobal()),

      ListTile(
          title: const Text(_customConfigurationGlobal),
          subtitle: const Text(_customConfigurationGlobalSub),
          onTap: () => applyCustomConfigurationGlobal()),
      ListTile(
          title: const Text(_darkThemeGlobal),
          subtitle: const Text(_darkThemeGlobalSub),
          onTap: () => applyDarkThemeGlobal()),
    ];
    return Scaffold(
        appBar: AppBar(title: const Text(_pspdfkitFlutterPluginTitle)),
        body: ExampleListView(currentTheme, frameworkVersion(), listTiles));
  }
}

class ExampleListView extends StatelessWidget {
  final ThemeData themeData;
  final String frameworkVersion;
  final List<Widget> widgets;

  const ExampleListView(this.themeData, this.frameworkVersion, this.widgets,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(top: 24),
          child: Center(
              child: Text(frameworkVersion,
                  style: themeData.textTheme.headline4?.copyWith(
                      fontSize: _fontSize,
                      fontWeight: FontWeight.bold,
                      color: themeData.primaryColor)))),
      Expanded(
          child: ListView.separated(
              itemCount: widgets.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (BuildContext context, int index) => widgets[index]))
    ]);
  }
}
