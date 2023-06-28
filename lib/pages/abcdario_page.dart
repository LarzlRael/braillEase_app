part of 'pages.dart';

class AbcdarioPage extends StatelessWidget {
  final PageRouteParams pageArgs;
  const AbcdarioPage({super.key, required this.pageArgs});
  @override
  Widget build(BuildContext context) {
    final text = pageArgs.phase;

    final listGenerate = getLetterConverted(text);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppbar(
                titlePage: pageArgs.titlePage,
              ),
              Container(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.15),
                  ),
                  shrinkWrap: true,
                  itemCount: text.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 3,
                      color: Colors.purple,
                      child: Column(
                        children: [
                          LetterBraile(
                            word: listGenerate[index],
                          ),
                          line(),
                          Text(
                            text[index] + " - " + text[index].toUpperCase(),
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
      ),
    );
  }
}
