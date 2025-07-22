import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/add_expense/add_expense_screen.dart';
import '../screens/expense_list/expense_list_screen.dart';
import '../screens/transit/transit_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/settings/settings_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/add-expense':
        return MaterialPageRoute(builder: (_) => const AddExpenseScreen());
      case '/expenses':
        return MaterialPageRoute(builder: (_) => const ExpenseListScreen());
      case '/transit':
        return MaterialPageRoute(builder: (_) => const TransitScreen());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
