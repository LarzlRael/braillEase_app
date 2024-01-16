import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:templat_project/firebase_options.dart';
import 'package:templat_project/provider/providers.dart';
import 'package:templat_project/router/app_router.dart';
import 'package:templat_project/theme/theme.dart';
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
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final globalProviderS = ref.watch(globalProvider);

    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme(isDarkMode: globalProviderS.isDarkModeEnabled).getTheme(),
      builder: (context, child) => HandleNotificationInteraction(
        child: child!,
      ),
    );
  }
}
