part of 'pages.dart';

final slidesItems = <SlideItem>[
  SlideItem(
      assetImage: 'assets/icons/braille.png',
      title: "Tu puerta al mundo táctil",
      subtitle:
          "Descubre el lenguaje de los puntos y abre un mundo lleno de conocimiento y comunicación"),
  SlideItem(
      assetImage: 'assets/slideshow/braille_1.png',
      title: "Siente el Conocimiento con $appName",
      subtitle: "Ayuda con la tarea propuesta y gana dinero por ello."),
  SlideItem(
      assetImage: 'assets/slideshow/braille_2.jpg',
      title: "Toca la Educación y la Inclusión",
      subtitle:
          "Conviértete en un experto del braille y abre puertas a una vida llena de aprendizaje y comprensión.")
];

class WelcomePage extends HookConsumerWidget {
  static const String routeName = 'welcome_page';
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    /* final themeProvider = context.watch<ThemeProviderNotifier>();
    final globaProvider = context.watch<GlobalProvider>(); */
    final isLastPage = useState(false);
    final globaProviderState = ref.watch(globalProvider);
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 475,
                child: Swiper(
                  loop: false,
                  onIndexChanged: (value) {
                    print('onIndexChanged: $value');
                    if (value == slidesItems.length - 1) {
                      isLastPage.value = true;
                    } else {
                      isLastPage.value = false;
                    }
                  },
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      activeColor: Colors.blue,
                      color: Colors.grey,
                      activeSize: 18.5,
                      size: 14.0,
                    ),
                  ),
                  itemCount: slidesItems.length,
                  itemBuilder: (context, index) {
                    final slide = slidesItems[index];
                    return slide;
                  },
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 0,
              child: TextButton(
                child: Text('Saltar'),
                onPressed: () {
                  goToNextPage(context);
                },
              ),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: AnimatedOpacity(
                opacity: isLastPage.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: FilledButton(
                  onPressed: () {
                    goToNextPage(context);
                  },
                  child: Text('Comenzar'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void goToNextPage(BuildContext context) async {
    await KeyValueStorageServiceImpl().setKeyValue<bool>(
      IS_FIRST_TIME_KEY,
      false,
    );
    context.go('/');
  }
}
