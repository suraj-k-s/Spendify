import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spendify/local_notification_service.dart';
import 'package:spendify/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spendify/work_manager_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    LocalNotificationService.init(),
    WorkManagerService().init(),
  ]);
  var status = await Permission.notification.status;
  if (status.isDenied) {
    Permission.notification.request();
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final now = DateTime.now();
  final selectedTime = DateTime(now.year, now.month, now.day, 18, 0, 0);
  LocalNotificationService.showDailyEveningNotification(selectedTime);
  runApp(const MainApp());
}

class AppColors {
  static const primaryColor = Color.fromARGB(255, 0, 30, 80);
  static const accentColor = Colors.blue;
  static const white = Colors.white;
  static const black = Colors.black;
  static const green = Color.fromARGB(255, 0, 176, 6);
  static const lightpink = Color.fromARGB(255, 253, 244, 244);
  static const lightblue = Color.fromARGB(255, 222, 231, 246);
  static const whiteblue = Color.fromARGB(255, 207, 221, 233);
  static const darkblue = Color.fromARGB(255, 13, 83, 188);
  static const tileprimaryblue = Color.fromARGB(255, 187, 222, 251);
  static const tilesecondaryblue = Color.fromARGB(255, 227, 242, 253);
  static const red = Color.fromARGB(255, 187, 29, 29);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
