import 'package:flutter/material.dart';
import 'package:project4/Model/expense.dart';
import 'package:project4/chart.dart';
import 'package:project4/expenses_list.dart';
import 'package:project4/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registerExpenses = [
    Expense('Web Coarse', 40.99, DateTime.now(), Category.work),
    Expense('GYM', 50.99, DateTime.now(), Category.work)
  ];

  void openaddexpense() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Newexpense(addexpense);
        });
  }

  void addexpense(Expense expense) {
    setState(() {
      registerExpenses.add(expense);
    });
  }

  void removeexpense(Expense expense) {
    final expenseindex = registerExpenses.indexOf(
        expense); 
    setState(() {
      registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 4),
      content: const Text('Expense Deleted!'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registerExpenses.insert(expenseindex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget maincontent = const Text('No expense found start adding one');
    if (registerExpenses.isNotEmpty) {
      maincontent = Expenseslist(removeexpense, registerExpenses);
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Expense Tracker'),
          actions: [
            IconButton(onPressed: openaddexpense, icon: const Icon(Icons.add))
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: registerExpenses),
                  Expanded(child: maincontent)
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: registerExpenses)),
                  Expanded(child: maincontent)
                ],
              ));
  }
}
