part of 'pages.dart';

class AbcdarioPage extends StatelessWidget {
  final PageRouteParams pageArgs;
  const AbcdarioPage({super.key, required this.pageArgs});
  @override
  Widget build(BuildContext context) {
    final globalProvider = context.read<GlobalProvider>();
    final listGenerate = getLetterConverted(pageArgs.phase);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              titlePage: pageArgs.titlePage,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.15),
                ),
                shrinkWrap: true,
                itemCount: pageArgs.phase.length,
                itemBuilder: (_, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 3,
                    color: globalProvider.pickerColor,
                    child: Column(
                      children: [
                        LetterBraile(
                          word: listGenerate[index],
                        ),
                        line(),
                        Text(
                          pageArgs.phase[index] +
                              " - " +
                              pageArgs.phase[index].toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
