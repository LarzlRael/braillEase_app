part of 'pages.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = 'settings_page';
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final fadeInTransition = context.read<ThemeProviderNotifier>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Settings Page',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            /*  Text(
              'FadeInTransition: ${fadeInTransition.fadeInTransition}',
              style: Theme.of(context).textTheme.titleLarge,
            ), */
            Switch(
              value: fadeInTransition.isDarkModeEnabled,
              onChanged: (value) {
                fadeInTransition.toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
