import 'package:flutter/material.dart';
import 'package:project4/Model/expense.dart';

class Expenseitem extends StatelessWidget {
  const Expenseitem(this.expense, {super.key});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(), // move lft and rgt
                Row(
                  children: [
                    Icon(categoryIcon[expense.category]),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(expense.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
