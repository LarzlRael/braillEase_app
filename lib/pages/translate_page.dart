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
  late GlobalProvider globalProvider;
  String textBraille = "";

  @override
  initState() {
    super.initState();
    globalProvider = Provider.of<GlobalProvider>(context, listen: false);
  }

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
                        decoration: InputDecoration(
                          hintText: "Ingrese su texto aquí",
                          border: InputBorder.none,
                          suffixIcon: textController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    textController.text = "";
                                    textController.clear();
                                    setState(() {
                                      text = "";
                                      textBraille = "";
                                    });
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: globalProvider.pickerColor,
                                  ),
                                )
                              : null,
                        ),
                        onChanged: (value) {
                          setState(() {
                            text = value;
                            textBraille = convertToBraillex(value);
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
                              textBraille,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 20,
                                    color: globalProvider.pickerColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                    ),
                  ),
                  /* CheckboxListTile(
                    title: Text("Show text"),
                    value: isSwitched,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value!;
                      });
                    },
                  ), */
                ],
              ),
            )),
      ),
    );
  }
}
