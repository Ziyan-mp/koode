import 'package:flutter/material.dart';
import '../config/app_routes.dart';
import '../config/app_theme.dart';
import 'app_router.dart';

class KoodeApp extends StatelessWidget {
  const KoodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koode',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}