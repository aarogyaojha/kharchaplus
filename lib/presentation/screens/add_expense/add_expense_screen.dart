import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/repositories/expense_repository.dart';
import '../../../domain/models/expense.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/shared/app_text_field.dart';
import '../../widgets/shared/app_button.dart';

class AddExpenseScreen extends StatefulWidget {
  final double? prefilledAmount;
  final String? prefilledCategory;
  final String? prefilledNotes;

  const AddExpenseScreen({
    super.key,
    this.prefilledAmount,
    this.prefilledCategory,
    this.prefilledNotes,
  });

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  final _tagsController = TextEditingController();
  final _repository = ExpenseRepository();

  String _selectedCategory = AppConstants.categories.first;
  String _selectedPaymentMethod = AppConstants.paymentMethods.first;

  @override
  void initState() {
    super.initState();
    if (widget.prefilledAmount != null) {
      _amountController.text = widget.prefilledAmount.toString();
    }
    if (widget.prefilledCategory != null) {
      _selectedCategory = widget.prefilledCategory!;
    }
    if (widget.prefilledNotes != null) {
      _notesController.text = widget.prefilledNotes!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                label: 'Amount',
                hint: 'Enter amount',
                controller: _amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
                suffixIcon: const Icon(Icons.currency_rupee),
              ),

              const SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
                items: AppConstants.categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Row(
                      children: [
                        Icon(AppConstants.categoryIcons[category], size: 20),
                        const SizedBox(width: 8),
                        Text(category),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Payment Method Dropdown
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                decoration: InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
                items: AppConstants.paymentMethods.map((method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              AppTextField(
                label: 'Notes',
                hint: 'Description of expense',
                controller: _notesController,
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              AppTextField(
                label: 'Tags (optional)',
                hint: 'Comma-separated tags',
                controller: _tagsController,
              ),

              const SizedBox(height: 32),

              AppButton(
                text: 'Add Expense',
                icon: Icons.add,
                onPressed: _submitExpense,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitExpense() {
    if (_formKey.currentState!.validate()) {
      final expense = Expense(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: double.parse(_amountController.text),
        category: _selectedCategory,
        paymentMethod: _selectedPaymentMethod,
        notes: _notesController.text,
        tags: _tagsController.text
            .split(',')
            .map((tag) => tag.trim())
            .where((tag) => tag.isNotEmpty)
            .toList(),
        date: DateTime.now(),
      );

      _repository.addExpense(expense);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Expense added: ${AppConstants.currency} ${expense.amount}',
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    _tagsController.dispose();
    super.dispose();
  }
}
