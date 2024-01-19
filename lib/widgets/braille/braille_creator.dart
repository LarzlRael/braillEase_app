part of '../widgets.dart';

class LetterBraileCreator extends ConsumerWidget {
  final double? childAspectRatio;
  final Function(List<bool>) onWordChanged;
  final List<bool>? params;
  LetterBraileCreator({
    Key? key,
    this.childAspectRatio,
    this.params,
    required this.onWordChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final brailleProviderS = ref.watch(brailleProvider);
    final brailleProviderN = ref.read(brailleProvider.notifier);
    return Container(
      margin: EdgeInsets.all(13),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 13,
        childAspectRatio: childAspectRatio ?? 1,
        mainAxisSpacing: 13,
        children: List.generate(
          brailleProviderS.word.length,
          (index) => GestureDetector(
            onTap: () {
              brailleProviderN.setWordIndex(
                index,
                !brailleProviderS.word[index],
                (updatedWord) {
                  onWordChanged(updatedWord);
                },
              );
            },
            child: Point(
              /* selected: word[index], */
              selected: brailleProviderS.word[index],
            ),
          ),
        ),
      ),
    );
  }
}

class Point extends StatelessWidget {
  final bool selected;
  const Point({Key? key, required this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: selected ? Colors.white : null,
        shape: BoxShape.circle,
        border: selected
            ? null
            : Border.all(
                color: Colors.white,
                width: 1.5,
              ),
      ),
    );
  }
}
