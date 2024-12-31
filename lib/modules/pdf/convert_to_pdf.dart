import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

Future<void> convertDocxToPdf(String docxPath, String pdfPath) async {
  // Load the .docx file as bytes
  final docxFile = File(docxPath);
  final docxBytes = await docxFile.readAsBytes();

  // Create a PDF document
  final pdf = pw.Document();

  // Example: Add static text since `docx_template` generates binary content
  pdf.addPage(
    pw.Page(
      build: (context) => pw.Text("DOCX content conversion example."),
    ),
  );

  // Save the PDF file
  final pdfFile = File(pdfPath);
  await pdfFile.writeAsBytes(await pdf.save());
  print("PDF generated at $pdfPath");
}
