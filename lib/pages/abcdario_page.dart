part of 'pages.dart';

class AbcdarioPage extends StatefulWidget {
  final PageRouteParams pageArgs;
  const AbcdarioPage({super.key, required this.pageArgs});

  @override
  State<AbcdarioPage> createState() => _AbcdarioPageState();
}

class _AbcdarioPageState extends State<AbcdarioPage> {
  @override
  Widget build(BuildContext context) {
    final globalProvider = context.read<GlobalProvider>();
    final listGenerate = getLetterConverted(widget.pageArgs.phase);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              titlePage: widget.pageArgs.titlePage,
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
                itemCount: widget.pageArgs.phase.length,
                itemBuilder: (_, int index) {
                  final letter = widget.pageArgs.phase[index];
                  final listGenerated = listGenerate[index];
                  return BraileLetterCard(
                    globalProvider: globalProvider,
                    listGenerated: listGenerated,
                    letter: letter,
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

class BraileLetterCard extends StatelessWidget {
  const BraileLetterCard({
    super.key,
    required this.globalProvider,
    required this.listGenerated,
    required this.letter,
  });

  final GlobalProvider globalProvider;
  final List<bool> listGenerated;
  final String letter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/details',
          extra: DetailPageRouteParams(
            letter: letter,
            listGenerated: listGenerated,
          ),
        );
      },
      child: Hero(
        tag: letter,
        child: DecoratedBox(
          decoration: BoxDecoration(
              /* boxShadow: [
              BoxShadow(
                color: globalProvider.pickerColor.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(1, .2),
              ),
            ], */
              ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 0,
            color: globalProvider.pickerColor,
            child: Column(
              children: [
                LetterBraile(
                  word: listGenerated,
                ),
                line(),
                Text(
                  textInAlphabet(letter),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
