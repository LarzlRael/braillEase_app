part of 'providers.dart';

class NotificationProvider extends ChangeNotifier {
//constructor
  NotificationProvider() {
    /* initialStatusCheck(); */
    _getAndSaveFCMToken();
    _onForegroundMessage();
  }
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  KeyValueStorageServiceImpl keyValueStorageServiceImpl =
      KeyValueStorageServiceImpl();

  late String? token;
  Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    /* await requestPermission(); */

    token = (await messaging.getToken());

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

  void _getAndSaveFCMToken() async {
    token = (await messaging.getToken())!;
    final getToken =
        await keyValueStorageServiceImpl.getValue<String>(FCM_TOKEN);
    if (token == getToken) {
      return;
    }
    print('FCM Token: $token');
    await keyValueStorageServiceImpl.setKeyValue<String>(FCM_TOKEN, token!);
    await Request.sendRequest(
      RequestType.get,
      '/notifications/saveDeviceId/$token/$packageName',
    );
    notifyListeners();
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;
    print('onMessage: ${message.notification}');
    /* final notification = PushMessage(
      messageId: clearMessageId(message.messageId),
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
          ? message.notification!.android?.imageUrl
          : message.notification!.apple?.imageUrl,
    );
    LocalNotification.showLocalNotification(
      id: notification.messageId.hashCode,
      body: notification.body,
      data: notification.messageId,
      title: notification.title,
    );
    add(NotificationsReceived(notification)); */
  }
}
