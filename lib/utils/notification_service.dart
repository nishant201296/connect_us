import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static NotificationService _notificationService;
  NotificationDetails _channel;
  FlutterLocalNotificationsPlugin _plugin;
  Function _onNotificationClick;
  static final String _CHANNEL_ID = "CONNECT_US_CHANNEL_ID";
  static final String _CHANNEL_NAME = "CONNECT_US_CHANNEL_NAME";
  static final String _CHANNEL_DESCRIPTION = "CONNECT_US_CHANNEL_DESCRIPTION";
  static NotificationService getInstance() {
    if (_notificationService == null) {
      _notificationService = NotificationService._();
    }
    return _notificationService;
  }

  NotificationService._();
  void _createChannel() {
    AndroidNotificationDetails androidNotificationChannel = AndroidNotificationDetails(
        _CHANNEL_ID, _CHANNEL_NAME, _CHANNEL_DESCRIPTION,
        importance: Importance.max, priority: Priority.max);
    _channel = NotificationDetails(android: androidNotificationChannel);
  }

  void initialize() {
    // initializing plugin
    _plugin = FlutterLocalNotificationsPlugin();

    // providing android settings
    AndroidInitializationSettings androidSettings = AndroidInitializationSettings("ic_stat_4k");
    _plugin.initialize(InitializationSettings(android: androidSettings),
        onSelectNotification: _onNotificationClick);
    _createChannel();
  }

  void displayNotification(int notificationId, String notificationTitle, String notificationBody,
      {String payload, Function onNotificationClick}) {
    _onNotificationClick = onNotificationClick;
    _plugin.show(notificationId, notificationTitle, notificationTitle, _channel, payload: payload);
  }
}
