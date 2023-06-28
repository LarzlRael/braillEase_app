part of '../widgets.dart';

class CustomAppbar extends StatelessWidget {
  final String titlePage;

  const CustomAppbar({super.key, required this.titlePage});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: context.pop,
          icon: Icon(Icons.chevron_left),
        ),
        Hero(
          tag: titlePage,
          child: Expanded(
            child: Text(
              titlePage + "" + convertToBraillex(titlePage),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}
