part of '../widgets.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool indicatorTopPosition;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryBullet;
  final double secondaryBullet;
  const Slideshow({
    Key? key,
    required this.slides,
    this.indicatorTopPosition = false,
    this.primaryBullet = 12.0,
    this.secondaryBullet = 12.0,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideShowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              Provider.of<_SlideShowModel>(context).primaryColorValue =
                  primaryColor;
              Provider.of<_SlideShowModel>(context).secondaryColorValue =
                  secondaryColor;
              Provider.of<_SlideShowModel>(context).primaryBulletValue =
                  primaryBullet;
              Provider.of<_SlideShowModel>(context).secondaryBulletValue =
                  secondaryBullet;
              return _CreateSlideShow(
                indicatorTopPosition: indicatorTopPosition,
                slides: slides,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CreateSlideShow extends StatelessWidget {
  const _CreateSlideShow({
    Key? key,
    required this.indicatorTopPosition,
    required this.slides,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  final bool indicatorTopPosition;
  final List<Widget> slides;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (indicatorTopPosition)
          _Dots(
              totalSlides: slides.length,
              primaryColor: primaryColor,
              secondaryColor: secondaryColor),
        Expanded(
          /* color: Colors.blue,
          height: MediaQuery.of(context).size.height * 0.48, */
          child: _Slides(slides: slides),
        ),
        if (!indicatorTopPosition)
          _Dots(
              totalSlides: slides.length,
              primaryColor: primaryColor,
              secondaryColor: secondaryColor)
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;
  final Color primaryColor;
  final Color secondaryColor;
  const _Dots({
    Key? key,
    required this.totalSlides,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalSlides,
          (index) => _Dot(
            index: index,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  final Color primaryColor;
  final Color secondaryColor;
  const _Dot({
    Key? key,
    required this.index,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlideShowModel>(context);
    Color color;
    double size;
    if (ssModel.currentPageValue >= index - 0.5 &&
        ssModel.currentPageValue <= index + 0.5) {
      size = ssModel.primaryBulletValue;
      color = ssModel.primaryColorValue;
    } else {
      size = ssModel.secondaryBulletValue;
      color = ssModel.secondaryColorValue;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  const _Slides({
    Key? key,
    required this.slides,
  }) : super(key: key);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      Provider.of<_SlideShowModel>(context, listen: false).currentPageValue =
          pageViewController.page!;

      context.read<GlobalProvider>().setIsLastPageSlider =
          pageViewController.page!.toInt() == widget.slides.length - 1;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /* color: Colors.blue, */
      padding: const EdgeInsets.all(10),
      child: PageView(
        controller: pageViewController,
        children: widget.slides
            .map((slide) => _Slide(
                  slide: slide,
                ))
            .toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide({Key? key, required this.slide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(10),
      child: slide,
    );
  }
}

class _SlideShowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.white;
  double _primaryBullet = 12;
  double _secondaryBullet = 12;
  double get currentPageValue => _currentPage;

  bool _isLastPageSlider = false;

  bool get isLastPageSlider => _isLastPageSlider;
  set isLastPageSlider(bool value) {
    _isLastPageSlider = value;
    notifyListeners();
  }

  set currentPageValue(double value) {
    _currentPage = value;
    notifyListeners();
  }

  Color get primaryColorValue => _primaryColor;
  set primaryColorValue(Color value) {
    _primaryColor = value;
  }

  Color get secondaryColorValue => _secondaryColor;
  set secondaryColorValue(Color value) {
    _secondaryColor = value;
  }

  double get primaryBulletValue => _primaryBullet;
  set primaryBulletValue(double value) {
    _primaryBullet = value;
  }

  double get secondaryBulletValue => _secondaryBullet;
  set secondaryBulletValue(double value) {
    _secondaryBullet = value;
  }
}
