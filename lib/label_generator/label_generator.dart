import 'dart:typed_data';
import 'label_printer_windows.dart' if (kIsWeb) 'package:excelprinttest/label_generator/label_printer_html.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class LabelGenerator {
  static late PdfPageFormat pageFormat;

  void setPageFormat(PdfPageFormat pageFormat) {
    LabelGenerator.pageFormat = pageFormat;
  }

  Future<void> generateLabelPdf({required pw.Document pdf, required Function(Uint8List bytes)? onPrint}) async {
    final Uint8List pdfBytes = await pdf.save();
    if (onPrint != null) {
      onPrint.call(pdfBytes);
    } else {
      printPdf(pdfBytes);
    }
  }
}
