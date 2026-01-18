import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import '../models/TollCar.dart';

class PdfHelper {
  static Future<void> generateAndPrint(List<TollCar> cars) async {
    final doc = pw.Document();

    // Use a standard font
    final font = await PdfGoogleFonts.nunitoExtraLight();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            // 1. Header
            pw.Header(
                level: 0,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Daily Toll Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                      pw.Text(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())),
                    ]
                )
            ),

            pw.SizedBox(height: 20),

            // 2. Table
            pw.TableHelper.fromTextArray(
              context: context,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.teal),
              rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300))),
              cellAlignment: pw.Alignment.centerLeft,
              data: <List<String>>[
                ['Car No.', 'Type', 'Lane', 'Operator', 'Time', 'Amount'], // Headers
                ...cars.map((car) => [
                  car.carNumber,
                  car.vehicleType,
                  car.laneNumber, // Matches your code
                  car.operatorId.substring(0, 5), // Show first 5 chars of ID to keep it short
                  DateFormat('HH:mm').format(car.createdAt),
                  "\$${car.tollAmount.toStringAsFixed(0)}",
                ]).toList(),
              ],
            ),

            pw.SizedBox(height: 20),

            // 3. Total Summary
            pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                    "Total Revenue: \$${cars.fold<double>(0, (sum, item) => sum + item.tollAmount).toStringAsFixed(0)}",
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.teal)
                )
            )
          ];
        },
      ),
    );

    // Open the Print/Share dialog
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }
}