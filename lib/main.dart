import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/restaurant_list_screen.dart';
import 'providers/restaurant_provider.dart';
import 'theme/app_theme.dart';

void main() {
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
      debugShowCheckedModeBanner: false,
      theme: isDark ? AppTheme.dark : AppTheme.light,
      home: RestaurantListScreen(),
    );
  }
}
