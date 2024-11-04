import 'dart:typed_data';
import 'package:printing/printing.dart';

import 'label_generator.dart';

Future<void> printPdf(Uint8List pdfBytes) async {
  await Printing.layoutPdf(onLayout: (_) => pdfBytes, format: LabelGenerator.pageFormat);
}
