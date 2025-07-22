import '../../domain/models/expense.dart';
import '../../domain/models/transit_route.dart';

class ExpenseRepository {
  static final List<Expense> _expenses = [
    Expense(
      id: '1',
      amount: 30.0,
      category: 'Transport',
      paymentMethod: 'Cash',
      notes: 'Bus fare to work',
      tags: ['daily', 'commute'],
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Expense(
      id: '2',
      amount: 150.0,
      category: 'Food',
      paymentMethod: 'eSewa',
      notes: 'Lunch at restaurant',
      tags: ['food', 'lunch'],
      date: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    Expense(
      id: '3',
      amount: 80.0,
      category: 'Shopping',
      paymentMethod: 'Khalti',
      notes: 'Grocery items',
      tags: ['grocery', 'essentials'],
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  static final List<TransitRoute> _routes = [
    TransitRoute(
      id: '1',
      name: 'Ring Road Service',
      from: 'Ratnapark',
      to: 'Kalanki',
      fare: 25.0,
      type: 'Bus',
    ),
    TransitRoute(
      id: '2',
      name: 'Valley Express',
      from: 'Bhaktapur',
      to: 'Kathmandu',
      fare: 35.0,
      type: 'Bus',
    ),
    TransitRoute(
      id: '3',
      name: 'City Connector',
      from: 'Patan',
      to: 'Thamel',
      fare: 20.0,
      type: 'Bus',
    ),
  ];

  List<Expense> getAllExpenses() => List.unmodifiable(_expenses);

  List<TransitRoute> getAllRoutes() => List.unmodifiable(_routes);

  void addExpense(Expense expense) {
    _expenses.insert(0, expense);
  }

  double getTodayTotal() {
    final today = DateTime.now();
    return _expenses
        .where(
          (expense) =>
              expense.date.year == today.year &&
              expense.date.month == today.month &&
              expense.date.day == today.day,
        )
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  Map<String, double> getCategoryTotals() {
    final Map<String, double> totals = {};
    for (final expense in _expenses) {
      totals[expense.category] =
          (totals[expense.category] ?? 0) + expense.amount;
    }
    return totals;
  }
}
