part of '../widgets.dart';

class CustomAppbar extends StatelessWidget {
  final String titlePage;
  final List<Widget>? actions;
  const CustomAppbar({super.key, required this.titlePage, this.actions});
  @override
  Widget build(BuildContext context) {
    return Row(
      /* mainAxisAlignment: MainAxisAlignment.spaceBetween, */
      children: [
        IconButton(
          onPressed: context.pop,
          icon: Icon(Icons.chevron_left),
        ),
        Hero(
          tag: titlePage,
          child: Text(
            titlePage + "" + convertToBraillex(titlePage),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Spacer(),
        if (actions != null) ...actions!,
      ],
    );
  }
}
