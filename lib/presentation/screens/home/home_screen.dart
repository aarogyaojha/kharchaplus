// presentation/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:kharchaplus/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:kharchaplus/presentation/screens/expense_list/expense_list_screen.dart';
import 'package:kharchaplus/presentation/screens/settings/settings_screen.dart';
import 'package:kharchaplus/presentation/screens/transit/transit_screen.dart';
import '../../../domain/models/expense.dart';
import '../../widgets/shared/app_card.dart';
import '../../widgets/shared/app_button.dart';
import '../../../data/repositories/expense_repository.dart';
import '../../../core/constants/app_constants.dart';
import '../add_expense/add_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  // final ExpenseRepository _repository = ExpenseRepository();

  final List<Widget> _screens = [
    const _HomeContent(),
    const ExpenseListScreen(),
    const TransitScreen(),
    const DashboardScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KharchaPlus'), elevation: 0),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Expenses'),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: 'Transit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent();

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  final ExpenseRepository _repository = ExpenseRepository();

  @override
  Widget build(BuildContext context) {
    final todayTotal = _repository.getTodayTotal();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Daily Summary Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Expenses',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '${AppConstants.currency} ${todayTotal.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Quick Add Presets
          Text('Quick Add', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _QuickAddButton(
                  icon: Icons.directions_bus,
                  label: 'Bus Rs. 30',
                  onTap: () => _addQuickExpense(30, 'Transport', 'Bus fare'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickAddButton(
                  icon: Icons.local_cafe,
                  label: 'Tea Rs. 20',
                  onTap: () => _addQuickExpense(20, 'Food', 'Tea'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _QuickAddButton(
                  icon: Icons.restaurant,
                  label: 'Meal Rs. 150',
                  onTap: () => _addQuickExpense(150, 'Food', 'Meal'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickAddButton(
                  icon: Icons.shopping_bag,
                  label: 'Snacks Rs. 50',
                  onTap: () => _addQuickExpense(50, 'Food', 'Snacks'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Add New Expense Button
          AppButton(
            text: 'Add New Expense',
            icon: Icons.add,
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddExpenseScreen(),
                ),
              );
              if (result == true) {
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  void _addQuickExpense(double amount, String category, String notes) {
    _repository.addExpense(
      Expense(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: amount,
        category: category,
        paymentMethod: 'Cash',
        notes: notes,
        tags: [],
        date: DateTime.now(),
      ),
    );

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $notes - ${AppConstants.currency} $amount'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

class _QuickAddButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAddButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 32, color: Theme.of(context).primaryColor),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
