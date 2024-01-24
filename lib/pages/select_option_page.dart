part of 'pages.dart';

List<SelectMenuButtonArgs> generateOptions(BuildContext context) {
  return [
    SelectMenuButtonArgs(
      title: 'Alfabeto',
      onPress: () {
        context.push('/abecedario/Abcedario/abcdefghijklmnñopqrstuvwxyz');
      },
      icon: CustomIcons.abcdario_icon,
      color1: Color(0xffF2D572),
      color2: Color(0xffE06AA3),
    ),
    SelectMenuButtonArgs(
      title: 'Números',
      onPress: () {
        context.push(
          '/abecedario/Números/1234567890+-*=',
        );
      },
      icon: CustomIcons.numbers_icon,
      color1: Colors.green,
      color2: Colors.greenAccent,
    ),
  ];
}

class SelectOptionPage extends StatelessWidget {
  const SelectOptionPage({super.key});
  @override
  Widget build(BuildContext context) {
    final titlePage = 'Seleccionar opción';
    return Scaffold(
      appBar: AppBar(
        title: TitleAndBraillePhrase(titlePage: titlePage),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            AlignedGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              itemCount: generateOptions(context).length,
              itemBuilder: (_, index) {
                final item = generateOptions(context)[index];
                return ButtonSelectOption(
                  args: item,
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BannerWidget(),
            )
          ],
        ),
      ),
    );
  }
}

/*  ButtonSelectOption(
            title: 'Abecedário',
            onPress: () {
              context.push('/abecedario');
            },
            icon: Icons.abc,
            color1: Colors.blue,
            color2: Colors.blueGrey,
          ), */
