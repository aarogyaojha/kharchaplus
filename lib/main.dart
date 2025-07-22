import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/routes/app_router.dart';
import 'presentation/screens/home/home_screen.dart';

void main() {
  runApp(const KharchaPlusApp());
}

class KharchaPlusApp extends StatelessWidget {
  const KharchaPlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KharchaPlus',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
