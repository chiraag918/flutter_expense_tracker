import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense.dart';
import 'package:flutter_expense_tracker/widgets/expenses/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expensesList, required this.removeExpense});

  final List<Expense> expensesList;
  final void Function(Expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expensesList[index]),
          onDismissed: (direction) {
            removeExpense(expensesList[index]);
          },
          child: ExpensesItem(expensesList[index])),
    );
  }
}
