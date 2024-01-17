part of 'utils.dart';

class PopupMenuItemClass {
  final String title;
  final IconData icon;

  PopupMenuItemClass({
    required this.title,
    required this.icon,
  });
}

final List<PopupMenuItemClass> popupMenuItems = [
  PopupMenuItemClass(
    title: 'Compartir',
    icon: Icons.share,
  ),
  PopupMenuItemClass(
    title: 'Crear texto pdf',
    icon: Icons.picture_as_pdf_rounded,
  ),
];

class PopupMenu extends ConsumerWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final brailleProviderS = ref.watch(brailleProvider);
    void handleClick(String value) {
      switch (value) {
        case 'Compartir':
          ShareServiceImp().shareOnlyText(Uri.encodeFull(
            "${Environment.serverDeepLink}/phrase_maker_page/creador_de_frases/${brailleProviderS.normalText}",
          ));
          break;

        case 'Crear texto pdf':
          if (addCounterIntersitialAd()) {
            InterstitialAdManager.showAd();
          }

          context.push('/print_pdf_page');

          break;
      }
    }

    return PopupMenuButton<String>(
      onSelected: handleClick,
      itemBuilder: (BuildContext context) {
        return popupMenuItems.map((choice) {
          return PopupMenuItem<String>(
            value: choice.title,
            child: Row(
              children: [
                Icon(choice.icon),
                SizedBox(width: 5),
                Text(choice.title),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
