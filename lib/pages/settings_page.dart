part of 'pages.dart';

class SettingsPage extends ConsumerWidget {
  // create some values
  /* late GlobalProvider globalProvider;
  late ThemeProviderNotifier themeProviderNotifier; */
  /* @override
  void initState() {
    super.initState();
    globalProvider = context.read<GlobalProvider>();
    themeProviderNotifier = context.read<ThemeProviderNotifier>();
  } */

// ValueChanged<Color> callback
  /* void changeColor(Color color) {
    /* globalProvider.pickerColor = color; */
    UserPreferences.setPickerColor = color.value;

    context.pop();
  } */

  @override
  Widget build(BuildContext context, ref) {
    final globalProviderNotifier = ref.watch(settingsProvider.notifier);
    final globalProviderState = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuraciones'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              globalProviderNotifier.toggleTheme();
              /* UserPreferences.isDarkModeEnabled =
                  themeProviderNotifier.isDarkModeEnabled; */
            },
            title: Text('Cambiar tema'),
            leading: Icon(
              globalProviderState.isDarkModeEnabled
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
          ListTile(
            onTap: () => showPickerColor(context, ref),
            title: Text('Color actual'),
            leading: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: ref.watch(globalProvider).currentColor,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }

  showPickerColor(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Escoge un color'),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: ref.watch(globalProvider).pickerColor,
              onColorChanged: ref.read(globalProvider.notifier).setPickerColor,
              /* showLabel: true,
                                    pickerAreaHeightPercent: 0.8, */
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                ref.read(globalProvider.notifier).currentColor(
                      ref.watch(globalProvider).pickerColor,
                    );
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
