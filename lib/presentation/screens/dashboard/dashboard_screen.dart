import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../data/repositories/expense_repository.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/shared/app_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ExpenseRepository();
    final categoryTotals = repository.getCategoryTotals();
    final monthlyBudget = 10000.0; // Static budget
    final monthlySpent = categoryTotals.values.fold(0.0, (a, b) => a + b);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Monthly Budget Progress
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Budget',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: monthlySpent / monthlyBudget,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    monthlySpent > monthlyBudget * 0.8
                        ? Colors.red
                        : Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Spent: ${AppConstants.currency} ${monthlySpent.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Budget: ${AppConstants.currency} ${monthlyBudget.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Expense by Category Chart
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expenses by Category',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: categoryTotals.isNotEmpty
                      ? PieChart(
                          PieChartData(
                            sections: _buildPieChartSections(
                              categoryTotals,
                              context,
                            ),
                            centerSpaceRadius: 60,
                            sectionsSpace: 2,
                          ),
                        )
                      : const Center(child: Text('No expenses to display')),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Category Summary
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category Breakdown',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                ...categoryTotals.entries.map(
                  (entry) =>
                      _CategoryItem(category: entry.key, amount: entry.value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
    Map<String, double> categoryTotals,
    BuildContext context,
  ) {
    final colors = [
      Theme.of(context).primaryColor,
      Colors.blue,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.brown,
    ];

    return categoryTotals.entries.map((entry) {
      final index = categoryTotals.keys.toList().indexOf(entry.key);
      return PieChartSectionData(
        value: entry.value,
        title:
            '${(entry.value / categoryTotals.values.fold(0.0, (a, b) => a + b) * 100).toStringAsFixed(1)}%',
        color: colors[index % colors.length],
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}

class _CategoryItem extends StatelessWidget {
  final String category;
  final double amount;

  const _CategoryItem({Key? key, required this.category, required this.amount})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            AppConstants.categoryIcons[category] ?? Icons.more_horiz,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(category, style: Theme.of(context).textTheme.bodyLarge),
          ),
          Text(
            '${AppConstants.currency} ${amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
