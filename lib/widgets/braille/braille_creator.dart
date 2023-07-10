part of '../widgets.dart';

class LetterBraileCreator extends StatefulWidget {
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
  State<LetterBraileCreator> createState() => _LetterBraileCreatorState();
}

class _LetterBraileCreatorState extends State<LetterBraileCreator> {
  late List<bool> word;
  @override
  void initState() {
    super.initState();
    if (widget.params != null) {
      word = widget.params!;
    } else {
      word = [false, false, false, false, false, false];
    }
    setState(() {});
  }

  /* List<bool> word = [false, false, false, false, false, false]; */
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(13),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 13,
        childAspectRatio: widget.childAspectRatio ?? 1,
        mainAxisSpacing: 13,
        children: List.generate(
          word.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                word[index] = !word[index];
              });
              widget.onWordChanged(word);
            },
            child: Point(
              selected: word[index],
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
    return Container(
      decoration: BoxDecoration(
        color: selected ? Colors.white : null,
        shape: BoxShape.circle,
        border: selected
            ? null
            : Border.all(
                color: Colors.white,
                width: 1,
              ),
      ),
    );
  }
}
