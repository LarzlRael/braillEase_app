part of '../widgets.dart';

class ButtonSelectOption extends StatelessWidget {
  final SelectMenuButtonArgs args;

  const ButtonSelectOption({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onTap: args.onPress,
      child: Stack(
        children: [
          _ButtonSelectOptionBackground(
            color1: args.color1,
            color2: args.color2,
            icon: args.icon,
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Icon(
                        args.icon,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                    Wrap(
                      children: args.title
                          .split('')
                          .map((e) => Column(
                                children: [
                                  Text(
                                    e,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  /* line(), */
                                  Text(
                                    convertToBraillex(e),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectMenuButtonArgs {
  final String title;
  final Function() onPress;
  final IconData icon;
  final Color color1;
  final Color color2;

  SelectMenuButtonArgs({
    required this.title,
    required this.onPress,
    required this.icon,
    required this.color1,
    required this.color2,
  });
}

class _ButtonSelectOptionBackground extends StatelessWidget {
  final Color color1;
  final Color color2;
  final IconData icon;

  const _ButtonSelectOptionBackground({
    Key? key,
    required this.color1,
    required this.color2,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /* width: double.infinity, */
      height: 150,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color2.withOpacity(0.9),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(4, 6),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            color1,
            color2,
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
              left: -40,
              top: -40,
              child: Icon(
                icon,
                color: Colors.white.withOpacity(0.2),
                size: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
