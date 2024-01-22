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

class PopupMenu extends HookConsumerWidget {
  final String currentPage;
  const PopupMenu({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      InterstitialAdManager.loadAd();
      return () {};
    }, []);
    final brailleProviderS = ref.watch(brailleProvider);
    Future<void> handleClick(String value) async {
      switch (value) {
        case 'Compartir':
          ShareServiceImp().shareOnlyText(Uri.encodeFull(
            "${Environment.serverDeepLink}/$currentPage/${brailleProviderS.normalText}",
          ));
          break;

        case 'Crear texto pdf':
          await InterstitialAdManager.verifyAndShowAd();

          context.push('/print_pdf_page');

          break;
      }
    }

    return brailleProviderS.normalText.isEmpty
        ? SizedBox()
        : PopupMenuButton<String>(
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
