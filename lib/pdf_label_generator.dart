library pdf_label_generator;

import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_label_generator/label_generator/label_presets.dart';

import 'label_generator/label_generator.dart';

export 'label_generator/label_generator.dart';
export 'label_generator/label_presets.dart';



class PdfLabelGenerator{

  static PdfPageFormat pageFormat = const PdfPageFormat(86 * PdfPageFormat.mm, 39 * PdfPageFormat.mm);

  static Future<void> printLabel({required PdfGeneratorType type, Function(Uint8List bytes)? onPrint}) async {

    final LabelGenerator labelGenerator = LabelGenerator();
    labelGenerator.setPageFormat(pageFormat);

    late pw.Document pdf;

    if(type.pdf == null) {
      pdf = await LabelPresets.getSimpleLabel(pageFormat: pageFormat, qrCodeText: type.qrCodeText!, bottomText: type.bottomText!);
    } else {
      pdf = type.pdf!;
    }

    labelGenerator.generateLabelPdf(pdf: pdf, onPrint: onPrint);
  }
}

class PdfGeneratorType {
  pw.Document? pdf;
  String? qrCodeText;
  String? bottomText;

  PdfGeneratorType.custom({required this.pdf});

  PdfGeneratorType.simple({required this.qrCodeText, required this.bottomText});
}
