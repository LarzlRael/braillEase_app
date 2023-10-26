import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:provider/provider.dart';
import 'package:templat_project/firebase_options.dart';
import 'package:templat_project/provider/providers.dart';
import 'package:templat_project/router/app_router.dart';
import 'package:templat_project/utils/utils.dart';
import 'package:templat_project/widgets/widgets.dart';
import 'constants/constant.dart';
import 'env/environment_variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Environment.initEnviroment();
  await UserPreferences.init();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ChangeNotifierProvider(create: (_) => BrailleProvider()),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp.router(
        title: appName,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: appTheme.getTheme(),
        builder: (context, child) => HandleNotificationInteraction(
          child: child!,
        ),
      ),
    );
  }
}
