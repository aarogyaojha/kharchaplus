import 'package:flutter/material.dart';
import '../../../data/repositories/expense_repository.dart';
import '../../../domain/models/transit_route.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/shared/app_card.dart';
import '../../widgets/shared/app_button.dart';
import '../add_expense/add_expense_screen.dart';

class TransitScreen extends StatelessWidget {
  const TransitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ExpenseRepository();
    final routes = repository.getAllRoutes();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Routes',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                final route = routes[index];
                return _TransitRouteCard(route: route);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TransitRouteCard extends StatelessWidget {
  final TransitRoute route;

  const _TransitRouteCard({required this.route});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.directions_bus,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                route.name,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${route.from} → ${route.to}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Fare: ${AppConstants.currency} ${route.fare.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              AppButton(
                text: 'Log as Expense',
                isExpanded: false,
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddExpenseScreen(
                        prefilledAmount: route.fare,
                        prefilledCategory: 'Transport',
                        prefilledNotes:
                            '${route.from} to ${route.to} - ${route.name}',
                      ),
                    ),
                  );

                  if (result == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Transit expense logged!'),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
