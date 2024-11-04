import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class LabelPresets {
  static double getScaleByCustomPageFormat(PdfPageFormat format) {
    const defaultFormat = PdfPageFormat(86 * PdfPageFormat.mm, 39 * PdfPageFormat.mm);

    final widthFactor = format.width / defaultFormat.width;
    final heightFactor = format.height / defaultFormat.height;

    return min<double>(widthFactor, heightFactor);
  }

  static Future<pw.Document> getSimpleLabel({required PdfPageFormat pageFormat, required String qrCodeText, required String bottomText}) async {
    var qrBytes = await ScreenshotController().captureFromWidget(Container(height: 50, width: 50, child: QrImageView(data: qrCodeText)),
        delay: const Duration(milliseconds: 20), pixelRatio: 1.5);
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        build: (pw.Context context) {
          return pw.Transform.scale(
            scale: getScaleByCustomPageFormat(pageFormat),
            child: pw.Center(
              child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
                pw.Container(
                  width: 50,
                  child: pw.Image(pw.MemoryImage(qrBytes)),
                ),
                pw.Text(bottomText),
              ]),
            ),
          );
        },
      ),
    );
    return pdf;
  }
}
