import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Expenses(),
    ),
  );
}
