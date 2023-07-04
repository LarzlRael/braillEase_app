part of '../widgets.dart';

class SlideItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetImage;
  const SlideItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.assetImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodyMedium;
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(
                  10,
                  0,
                ),
              )
            ],
          ),
          child: Image.asset(
            assetImage,
            height: 250,
            width: 250,
          ),
        ),
        SizedBox(height: 15),
        Text(title, style: titleStyle, textAlign: TextAlign.center),
        SizedBox(height: 10),
        Text(subtitle, style: captionStyle, textAlign: TextAlign.center),
      ],
    );
  }
}
