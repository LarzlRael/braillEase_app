part of 'pages.dart';

class WelcomePage extends StatelessWidget {
  static const String routeName = 'welcome_page';
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final themeProvider = context.watch<ThemeProviderNotifier>();
    final globaProvider = context.watch<GlobalProvider>();
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 475,
                child: Slideshow(
                  primaryColor: colors.primary,
                  secondaryColor: Colors.grey,
                  primaryBullet: 15.0,
                  secondaryBullet: 10.0,
                  slides: [
                    SlideItem(
                        assetImage: 'assets/icons/braille.png',
                        title: "Tu puerta al mundo táctil",
                        subtitle:
                            "Descubre el lenguaje de los puntos y abre un mundo lleno de conocimiento y comunicación"),
                    SlideItem(
                        assetImage: 'assets/slideshow/braille_1.png',
                        title: "Siente el Conocimiento con $appName",
                        subtitle:
                            "Ayuda con la tarea propuesta y gana dinero por ello."),
                    SlideItem(
                        assetImage: 'assets/slideshow/braille_2.jpg',
                        title: "Toca la Educación y la Inclusión",
                        subtitle:
                            "Conviértete en un experto del braille y abre puertas a una vida llena de aprendizaje y comprensión.")
                  ],
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
            /* Container(
              margin: const EdgeInsets.symmetric(vertical: 32),
              child: const OnlyImageAndTitle(),
            ), */

            globaProvider.getIsLastPageSlider
                ? Positioned(
                    bottom: 15,
                    right: 15,
                    child: FadeInOpacity(
                      child: FilledButton(
                        onPressed: () {
                          goToNextPage(context);
                        },
                        child: Text('Comenzar'),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  void goToNextPage(BuildContext context) {
    UserPreferences.isFirstTime = false;
    context.go('/');
  }
}
