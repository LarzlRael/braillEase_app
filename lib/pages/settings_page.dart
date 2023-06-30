part of 'pages.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // create some values
  late GlobalProvider globalProvider;
  late ThemeProviderNotifier themeProviderNotifier;
  @override
  void initState() {
    super.initState();
    globalProvider = context.read<GlobalProvider>();
    themeProviderNotifier = context.read<ThemeProviderNotifier>();
  }

// ValueChanged<Color> callback
  void changeColor(Color color) {
    globalProvider.pickerColor = color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuraciones'),
      ),
      body: Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) {
          return ListView(
            children: [
              ListTile(
                onTap: () {
                  themeProviderNotifier.toggleTheme();
                  UserPreferences.isDarkModeEnabled =
                      themeProviderNotifier.isDarkModeEnabled;
                },
                title: Text('Cambiar tema'),
                leading: Icon(
                  themeProviderNotifier.isDarkModeEnabled
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Escoge un color'),
                        content: SingleChildScrollView(
                          child: MaterialPicker(
                            pickerColor: globalProvider.pickerColor,
                            onColorChanged: changeColor,
                            /* showLabel: true,
                                    pickerAreaHeightPercent: 0.8, */
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              globalProvider.currentColor =
                                  globalProvider.pickerColor;
                              context.pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                title: Text('Color actual'),
                leading: GestureDetector(
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: globalProvider.pickerColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
