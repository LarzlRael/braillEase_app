part of 'pages.dart';

class TranslatePage extends StatefulWidget {
  final PageRouteParams titlePage;
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
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppbar(
                    titlePage: widget.titlePage.titlePage,
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: textController,
                        maxLines: 6, //or null
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
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      height: 150,
                      child: isSwitched
                          ? Text(
                              text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 20,
                                  ),
                            )
                          : Text(
                              convertToBraillex(text),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
      ),
    );
  }
}
