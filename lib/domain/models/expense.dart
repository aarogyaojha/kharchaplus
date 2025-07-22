class Expense {
  final String id;
  final double amount;
  final String category;
  final String paymentMethod;
  final String notes;
  final List<String> tags;
  final DateTime date;

  Expense({
    required this.id,
    required this.amount,
    required this.category,
    required this.paymentMethod,
    required this.notes,
    required this.tags,
    required this.date,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      amount: json['amount'],
      category: json['category'],
      paymentMethod: json['paymentMethod'],
      notes: json['notes'],
      tags: List<String>.from(json['tags']),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'paymentMethod': paymentMethod,
      'notes': notes,
      'tags': tags,
      'date': date.toIso8601String(),
    };
  }
}
