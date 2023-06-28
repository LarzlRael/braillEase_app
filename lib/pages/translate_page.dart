part of 'pages.dart';

class TranslatePage extends StatefulWidget {
  final String titlePage;
  const TranslatePage({
    super.key,
    required this.titlePage,
  });

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  TextEditingController textController = TextEditingController();
  bool isSwitched = false;
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: widget.titlePage,
          child: Text(widget.titlePage),
        ),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  /* color: Colors.grey, */
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: textController,
                      maxLines: 8, //or null
                      decoration: InputDecoration.collapsed(
                        hintText: "Enter your text here",
                      ),
                      onChanged: (value) {
                        setState(() {
                          text = value;
                        });
                      },
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    child: isSwitched
                        ? Text(
                            text,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 20,
                                    ),
                          )
                        : Text(
                            convertToBraillex(text),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 20,
                                    ),
                          ),
                  ),
                ),
                Checkbox(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value!;
                    });
                  },
                ),
              ],
            ),
          )),
    );
  }
}
