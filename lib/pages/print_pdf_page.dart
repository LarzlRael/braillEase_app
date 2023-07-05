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
    final textTheme = Theme.of(context).textTheme;
    final List<PagesSizes> pagesSizes = [
      PagesSizes(
        sizeName: 'Carta',
        size: '21.59cm x 27.94cm',
        pageFormat: PdfPageFormat.letter,
      ),
      PagesSizes(
        sizeName: 'Legal',
        size: '21.59cm x 35.56cm',
        pageFormat: PdfPageFormat.legal,
      ),
      PagesSizes(
        sizeName: 'A4',
        size: '21.0cm x 29.7cm',
        pageFormat: PdfPageFormat.a4,
      ),
      PagesSizes(
        sizeName: 'A5',
        size: '14.8cm x 21.0cm',
        pageFormat: PdfPageFormat.a5,
      ),
      PagesSizes(
        sizeName: 'A6',
        size: '10.5cm x 14.8cm',
        pageFormat: PdfPageFormat.a6,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Selecciona tamaño")),
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
                leading: Icon(FontAwesomeIcons.filePdf),
                subtitle: Text(
                  pagesSizes[index].size,
                  style: textTheme.labelMedium,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
