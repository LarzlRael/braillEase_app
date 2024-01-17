part of '../widgets.dart';

class ButtonCategory extends StatelessWidget {
  final IconData icon;
  final Widget title;
  final Color color1;
  final Color color2;
  final VoidCallback onPress;

  const ButtonCategory({
    Key? key,
    required this.title,
    required this.onPress,
    this.icon = Icons.category,
    this.color1 = Colors.grey,
    this.color2 = Colors.blueGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        _ButtonBackGround(color1: color1, color2: color2, icon: icon),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                onTap: onPress,
                leading: Icon(
                  icon,
                  color: Colors.white,
                  size: 40,
                ),
                title: title,
                /*  const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      color: Colors.white,
                    ), */
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ButtonBackGround extends StatelessWidget {
  final Color color1;
  final Color color2;
  final IconData icon;

  const _ButtonBackGround({
    Key? key,
    required this.color1,
    required this.color2,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.all(20),
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
              right: -20,
              top: -20,
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
