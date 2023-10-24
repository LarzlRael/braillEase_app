part of 'providers.dart';

class NotificationProvider extends ChangeNotifier {
//constructor
  NotificationProvider() {
    /* initialStatusCheck(); */
    _getFCMToken();
  }
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late String token;
  Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    /* await requestPermission(); */

    token = (await messaging.getToken())!;

    print('Token: $token');
    notifyListeners();
    // Handlers
    /* FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp); */

    // Local Notifications
  }

  void initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
  }

  void _getFCMToken() async {
    final token = await messaging.getToken();
    print('FCM Token: $token');
  }
}
