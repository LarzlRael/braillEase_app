import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:provider/provider.dart';
import 'package:templat_project/provider/providers.dart';
import 'package:templat_project/router/app_router.dart';
import 'package:templat_project/utils/utils.dart';
import 'constants/constant.dart';
import 'env/environment_variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Enviroment.initEnviroment();
  await UserPreferences.init();
  return runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProviderNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeProviderNotifier>(context).appTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalProvider()),
        ChangeNotifierProvider(create: (_) => BraileProvider()),
      ],
      child: MaterialApp.router(
        title: appName,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: appTheme.getTheme(),
      ),
    );
  }
}
