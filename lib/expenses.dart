import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense.dart';
import 'package:flutter_expense_tracker/widgets/chart/chart.dart';
import 'package:flutter_expense_tracker/widgets/expenses/expenses_list.dart';
import 'package:flutter_expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void addExpenses(expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpenses(expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted."),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isDismissible: true,
      // To make the bottom sheet, take up the full screen
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addExpenses),
    );
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: width < 600
            ? Column(
                children: [
                  Expanded(
                    child: Chart(expenses: _registeredExpenses),
                  ),
                  Expanded(
                    child: (_registeredExpenses.isNotEmpty)
                        ? ExpensesList(
                            expensesList: _registeredExpenses,
                            removeExpense: removeExpenses,
                          )
                        : const Center(
                            child: Text(
                                "No expenses found. Click on + to add some."),
                          ),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Chart(expenses: _registeredExpenses),
                    ),
                    Expanded(
                      child: (_registeredExpenses.isNotEmpty)
                          ? ExpensesList(
                              expensesList: _registeredExpenses,
                              removeExpense: removeExpenses,
                            )
                          : const Center(
                              child: Text(
                                  "No expenses found. Click on + to add some."),
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
