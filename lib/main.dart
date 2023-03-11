import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/helper/database_helper.dart';
import 'package:restaurant_app/helper/navigation.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:restaurant_app/screen/favorite_screen.dart';
import 'package:restaurant_app/screen/list_restaurant_screen.dart';
import 'package:restaurant_app/screen/restaurant_detail_screen.dart';
import 'package:restaurant_app/screen/search_page.dart';
import 'package:restaurant_app/screen/setting_screen.dart';
import 'package:restaurant_app/screen/splash_screen.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'helper/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
            create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider<SearchRestaurantProvider>(
            create: (_) => SearchRestaurantProvider()),
        ChangeNotifierProvider<RestaurantDetailProvider>(
            create: (_) => RestaurantDetailProvider()),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider<SettingProvider>(
            create: (_) => SettingProvider()..loadPrefs())
      ],
      child: MaterialApp(
        title: 'Restaurant',
        initialRoute: SplashScreen.routeName,
        navigatorKey: navigatorKey,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          RestaurantListScreen.routeName: (context) =>
              const RestaurantListScreen(),
          SearchPage.routeName: (context) => const SearchPage(),
          RestaurantDetailScreen.routeName: (context) => RestaurantDetailScreen(
              restaurantElement: ModalRoute.of(context)?.settings.arguments
                  as RestaurantElement),
          FavoriteScreen.routeName: (context) => const FavoriteScreen(),
          SettingScreen.routeName: (context) => const SettingScreen()
        },
      ),
    );
  }
}
