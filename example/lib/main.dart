import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf_label_generator/pdf_label_generator.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TestPage(),
    );
  }
}

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Label PDF Generator')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                generate();
              },
              child: Text('Generate Label PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> generate() async {
    const pageFormat = PdfPageFormat(86 * PdfPageFormat.mm, 39 * PdfPageFormat.mm);

    final LabelGenerator labelGenerator = LabelGenerator();
    labelGenerator.setPageFormat(pageFormat);

    // var qrBytes = await ScreenshotController().captureFromWidget(Container(height: 50, width: 50, child: QrImageView(data: 'test123123')),
    //     delay: Duration(milliseconds: 20), pixelRatio: 1.5);
    // final pdf = pw.Document();
    //
    // pdf.addPage(
    //   pw.Page(
    //     pageFormat: pageFormat,
    //     build: (pw.Context context) {
    //       return pw.Center(
    //           child: pw.Row(children: [
    //             pw.Expanded(
    //               child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
    //                 pw.Text("This PDF was createddsds"),
    //                 pw.Text("This PDF was created"),
    //                 pw.Text("This PDF was created"),
    //                 pw.Text("This PDF was created"),
    //                 pw.Text("This PDF was created"),
    //                 pw.Text("This PDF was created"),
    //               ]),
    //             ),
    //             pw.Container(
    //               width: 50,
    //               child: pw.Image(pw.MemoryImage(qrBytes!)),
    //             ),
    //           ]));
    //     },
    //   ),
    // );
    PdfLabelGenerator.printLabel(type: PdfGeneratorType.simple(qrCodeText: 'qrCode', bottomText: 'ohohohohohoho'));
  }
}
