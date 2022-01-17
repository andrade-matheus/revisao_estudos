import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<tz.TZDateTime> horarioNotificacao() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  int horaNotificacao = sharedPreferences.getInt('HORA_NOTIFICACAO') ?? 9;
  int minutosNotificacao =
      sharedPreferences.getInt('MINUTOS_NOTIFICACAO') ?? 30;

  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
      now.day, horaNotificacao, minutosNotificacao);

  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

iniciarNotificacoes() async {
  var androidInitializationSetting =
      AndroidInitializationSettings("ic_launcher");

  var initializationSettings =
      InitializationSettings(android: androidInitializationSetting);

  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (payload) => null,
  );
}

agendarNotificacao() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  bool notificacaoDiaria =
      sharedPreferences.getBool('NOTIFICACAO_DIARIA') ?? true;

  if (!notificacaoDiaria) {
    flutterLocalNotificationsPlugin.cancelAll();
    return;
  }

  var androidDetails = AndroidNotificationDetails(
    "revisoes_diarias",
    "Reviões diárias",
    channelDescription: "Lembrete das reviões diárias",
    color: Color(0xFFF56D11),
    ledColor: Color(0xFFF56D11),
    ledOnMs: 50,
    ledOffMs: 50,
    enableVibration: true,
    playSound: true,
    importance: Importance.defaultImportance,
  );

  var generalDetails = NotificationDetails(android: androidDetails);

  tz.initializeTimeZones();
  tz.setLocalLocation(
      tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));

  var scheduleTime = await horarioNotificacao();

  flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    "Lembre de fazer suas revisões",
    "Venha ver suas revisões de hoje.",
    scheduleTime,
    generalDetails,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}
