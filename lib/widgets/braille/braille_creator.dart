part of '../widgets.dart';

class LetterBraileCreator extends StatelessWidget {
  final double? childAspectRatio;
  final Function(List<bool>) onWordChanged;
  final List<bool>? params;
  LetterBraileCreator({
    /* required this.word, */
    Key? key,
    this.childAspectRatio,
    this.params,
    required this.onWordChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brailleProvider = context.watch<BrailleProvider>();
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
          brailleProvider.getWord.length,
          (index) => GestureDetector(
            onTap: () {
              brailleProvider.setWordIndex(
                  index, !brailleProvider.getWord[index]);
              onWordChanged(brailleProvider.getWord);
            },
            child: Point(
              /* selected: word[index], */
              selected: brailleProvider.getWord[index],
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
