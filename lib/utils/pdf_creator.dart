part of 'utils.dart';

Future<void> createAndDownloadPdf(
  String textToPrint,
  BrailleState braileProvider,
) async {
  final fontData = await rootBundle.load('assets/dejavu_sans.ttf');
  final ttf = pw.Font.ttf(fontData.buffer.asByteData());
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: braileProvider.pagesSizes.pageFormat,
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
            level: 0,
            child: pw.Text('Braille'),
          ),
          pw.Paragraph(
            text: braileProvider.braileConverted,
            style: pw.TextStyle(
              font: ttf,
              fontSize: 20,
            ),
          ),
        ];
      },
    ),
  );
  // Obtener la ruta del directorio de almacenamiento externo
  final output = await getExternalStorageDirectory();
  final outputFile = File('${output!.path}/mi_archivo.pdf');

  if (await outputFile.exists()) {
    await outputFile.delete();
  }

  // Guardar el archivo PDF en el directorio
  await outputFile.writeAsBytes(await pdf.save());
  OpenFile.open(outputFile.path);
}
