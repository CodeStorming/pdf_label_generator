
import 'dart:html';
import 'dart:typed_data';

Future<void> printPdf(Uint8List pdfBytes)async {

  final blob = Blob([pdfBytes], 'application/pdf');
  final url = Url.createObjectUrlFromBlob(blob);
  final anchor = AnchorElement(href: url)
    ..setAttribute("download", "label_test.pdf")
    ..click();
  Url.revokeObjectUrl(url);
}