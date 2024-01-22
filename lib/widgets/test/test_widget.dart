part of '../widgets.dart';

class TestWidget extends ConsumerWidget {
  const TestWidget({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final globalProviderS = ref.watch(globalProvider);
    final makePhraseProviderS = ref.watch(brailleProvider);
    final makePhraseProviderN = ref.read(brailleProvider.notifier);
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: globalProviderS.currentColor,
                borderRadius: BorderRadius.circular(15),
              ),
              /* height: 500, */
              child: Column(
                children: [
                  LetterBraileCreator(
                    onWordChanged: makePhraseProviderN.handleWordChanged,
                    childAspectRatio: 1.5,
                  ),
                  /* line(), */
                  makePhraseProviderS.matchingCharacters.length == 1
                      ? FadeInOpacity(
                          duration: Duration(milliseconds: 250),
                          child: Text(
                            textInAlphabet(
                                makePhraseProviderS.wordToShow, false),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: makePhraseProviderS.matchingCharacters
                              .map(
                                (e) => FadeInOpacity(
                                  duration: Duration(milliseconds: 400),
                                  child: FilledButton(
                                    /* style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ), */
                                    onPressed: () {
                                      /* selectedAndPop(e); */
                                    },
                                    child: Text(e),
                                  ),
                                ),
                              )
                              .toList())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
