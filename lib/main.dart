import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/restaurant_detail_screen.dart';
import 'providers/restaurant_provider.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/restaurant_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Hive
  await Hive.initFlutter();
  await Hive.openBox('favorites');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
      ],
      child: RestaurantFinderApp(),
    ),
  );
}

class RestaurantFinderApp extends StatefulWidget {
  @override
  _RestaurantFinderAppState createState() => _RestaurantFinderAppState();
}

class _RestaurantFinderAppState extends State<RestaurantFinderApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Finder',
      debugShowCheckedModeBanner: false,
      theme: isDark ? AppTheme.dark : AppTheme.light,

      // Default screen
      initialRoute: '/login',

      routes: {
        '/login': (context) => LoginScreen(),
        '/list': (context) => RestaurantListScreen(),

        // ❌ DO NOT PUT DETAIL PAGE HERE
        // because it needs a Restaurant object
      },
    );
  }
}
