import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static initEnviroment() async {
    await dotenv.load(
        /* fileName: '.env', */
        );
  }

  static String googleMapsApiKey =
      dotenv.env['GOOGLE_MAPS_API_KEY'] ?? 'No está configurado el API_URL';
}
