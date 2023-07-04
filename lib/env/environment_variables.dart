import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnviroment() async {
    await dotenv.load(
      fileName: '.env',
    );
  }

  static String admobBanner =
      dotenv.env['ADMOB_BANNER'] ?? 'No está configurado el banner ID';
  static String admobIntersitial =
      dotenv.env['ADMOB_INTERSITIAL'] ?? 'No está configurado el banner ID';
}
