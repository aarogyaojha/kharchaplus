import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'KharchaPlus';
  static const String currency = 'Rs.';

  static const List<String> categories = [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Entertainment',
    'Health',
    'Education',
    'Other',
  ];

  static const List<String> paymentMethods = [
    'Cash',
    'eSewa',
    'Khalti',
    'Bank Transfer',
    'Credit Card',
  ];

  static const Map<String, IconData> categoryIcons = {
    'Food': Icons.restaurant,
    'Transport': Icons.directions_bus,
    'Shopping': Icons.shopping_bag,
    'Bills': Icons.receipt_long,
    'Entertainment': Icons.movie,
    'Health': Icons.local_hospital,
    'Education': Icons.school,
    'Other': Icons.more_horiz,
  };
}
