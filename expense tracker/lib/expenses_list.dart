import 'package:flutter/material.dart';
import 'package:project4/Model/expense.dart';
import 'package:project4/Model/expense_item.dart';

class Expenseslist extends StatelessWidget {
  const Expenseslist(this.onremove, this.expense, {super.key});

  final List<Expense> expense;
  final void Function(Expense expense) onremove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expense.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
              key: ValueKey(Expenseitem(expense[index])),
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              ),
              onDismissed: (direction) {
                onremove((expense[index]));
              },
              child: Expenseitem(expense[index]));
        });
  }
}
