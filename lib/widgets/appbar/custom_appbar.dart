part of '../widgets.dart';

class CustomAppbar extends StatelessWidget {
  final String titlePage;
  final List<Widget>? actions;
  const CustomAppbar({super.key, required this.titlePage, this.actions});
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
          child: TitleAndBraillePhrase(titlePage: titlePage),
        ),
        Spacer(),
        if (actions != null) ...actions!,
      ],
    );
  }
}
