part of 'pages.dart';

class AbecedarioPage extends ConsumerWidget {
  final PageRouteParams pageArgs;
  const AbecedarioPage({super.key, required this.pageArgs});

  @override
  Widget build(BuildContext context, ref) {
    final globalRef = ref.watch(globalProvider);
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
                  final letter = pageArgs.phase[index];
                  final listGenerated = listGenerate[index];
                  return BraileLetterCard(
                    globalState: globalRef,
                    listGenerated: listGenerated,
                    letter: letter,
                    onSelected: () {
                      context.push('/details/$letter');
                    },
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
    required this.globalState,
    required this.listGenerated,
    required this.letter,
    required this.onSelected,
  });

  final GlobalState globalState;
  final List<bool> listGenerated;
  final String letter;
  final Function() onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      /* () {
        /* context.push(
          '/details',
          extra: DetailPageRouteParams(
            letter: letter,
            listGenerated: listGenerated,
          ),
        ); */
      }, */
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
            color: globalState.pickerColor,
            child: Column(
              children: [
                LetterBraile(
                  word: listGenerated,
                  childAspectRatio: .9,
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

class BraileLetterCardPickeed extends StatelessWidget {
  const BraileLetterCardPickeed({
    super.key,
    required this.globalProvider,
    required this.listGenerated,
    required this.letter,
  });

  final GlobalState globalProvider;
  final List<bool> listGenerated;
  final String letter;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
    );
  }
}
