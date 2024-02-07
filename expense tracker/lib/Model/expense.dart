import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense(this.title, this.amount, this.date, this.category) : id = uuid.v4();
  final String id;
  final String title;
  final double amount; //2.3, 5.66
  final DateTime date;
  final Category
      category; // typo error occur if we declared category like we declared before

  get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (var expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
