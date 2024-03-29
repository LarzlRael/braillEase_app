part of '../widgets.dart';

class NoInformation extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool showButton;
  final String? buttonText;
  final VoidCallback? onPressed;
  final IconData iconButton;
  final Function()? onWidgetPressed;

  const NoInformation({
    Key? key,
    required this.icon,
    required this.text,
    required this.showButton,
    required this.iconButton,
    this.buttonText,
    this.onPressed,
    this.onWidgetPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        if (onWidgetPressed != null) {
          onWidgetPressed!();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 160),
              SimpleText(
                text: text,
                padding: const EdgeInsets.symmetric(vertical: 10),
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),
              showButton
                  ? OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        side: BorderSide(color: colors.primary), //<-- SEE HERE
                      ),
                      onPressed: onPressed,
                      icon: Icon(iconButton),
                      label: Text(
                        buttonText!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      /* paddingVertical: 12,
                          spaceBetweenIconAndText: 15,
                          label: buttonText ?? 'Text del boton',
                          fontSize: 15,
                          ghostButton: true,
                          backGroundColor: Colors.blue,
                          icon: iconButton,
                          textColor: Colors.white, */
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
