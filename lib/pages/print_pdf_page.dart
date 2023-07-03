part of 'pages.dart';

class PagesSizes {
  String sizeName;
  String size;
  PdfPageFormat pageFormat;
  PagesSizes({
    required this.sizeName,
    required this.size,
    required this.pageFormat,
  });
}

class PrintPdfPage extends StatelessWidget {
  const PrintPdfPage({super.key});
  @override
  Widget build(BuildContext context) {
    final braileProvider = Provider.of<BraileProvider>(context);
    final List<PagesSizes> pagesSizes = [
      PagesSizes(
        sizeName: 'Letter',
        size: '22cmx55cm',
        pageFormat: PdfPageFormat.letter,
      ),
      PagesSizes(
        sizeName: 'Legal',
        size: '22cmx55cm',
        pageFormat: PdfPageFormat.legal,
      ),
      PagesSizes(
        sizeName: 'A4',
        size: '22cmx55cm',
        pageFormat: PdfPageFormat.a4,
      ),
      PagesSizes(
        sizeName: 'A5',
        size: '22cmx55cm',
        pageFormat: PdfPageFormat.a5,
      ),
      PagesSizes(
        sizeName: 'A6',
        size: '22cmx55cm',
        pageFormat: PdfPageFormat.a6,
      ),
      /* PagesSizes(
        sizeName: 'Ledger',
        size: '22cmx55cm',
        pageFormat: PdfPageFormat.ledger,
      ), */
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Selecciona el tamaño")),
      body: Container(
        child: Center(
          child: ListView.builder(
            itemCount: pagesSizes.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () async {
                  braileProvider.setSelectedPagesSizes = pagesSizes[index];
                  await createAndDownloadPdf(
                    braileProvider.getBraileConverted,
                    braileProvider,
                  );
                },
                title: Text(pagesSizes[index].sizeName),
                leading: Icon(Icons.content_copy),
                subtitle: Text(pagesSizes[index].size),
              );
            },
          ),
        ),
      ),
    );
  }
}
