import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../data/repositories/expense_repository.dart';
import '../../../../domain/models/expense.dart';
import '../../../widgets/shared/app_card.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ExpenseRepository();
    final expenses = repository.getAllExpenses();

    // Group expenses by date
    final groupedExpenses = <String, List<Expense>>{};
    for (final expense in expenses) {
      final dateKey =
          '${expense.date.year}-${expense.date.month.toString().padLeft(2, '0')}-${expense.date.day.toString().padLeft(2, '0')}';
      groupedExpenses.putIfAbsent(dateKey, () => []).add(expense);
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: groupedExpenses.length,
        itemBuilder: (context, index) {
          final dateKey = groupedExpenses.keys.elementAt(index);
          final dateExpenses = groupedExpenses[dateKey]!;
          final date = dateExpenses.first.date;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  _formatDate(date),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              ...dateExpenses.map((expense) => _ExpenseItem(expense: expense)),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class _ExpenseItem extends StatelessWidget {
  final Expense expense;

  const _ExpenseItem({required this.expense});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              AppConstants.categoryIcons[expense.category] ?? Icons.more_horiz,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.notes,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '${expense.category} • ${expense.paymentMethod}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Text(
            '${AppConstants.currency} ${expense.amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
