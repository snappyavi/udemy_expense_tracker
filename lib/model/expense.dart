import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();
//will not be changed and be saved in memory for reusing

enum Categories { food, work, travel, leisure }

const CategoryIcons = {
  Categories.food: Icons.lunch_dining_sharp,
  Categories.leisure: Icons.movie_creation_outlined,
  Categories.work: Icons.work,
  Categories.travel: Icons.train,
};

class Expense {
  //constructor = formula for adding the expense when quoted by quote
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  //intialiser function = : id = uuid.v4()

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  //gets a value //transforms date into readable string
  //we use getter, a get indeed
  String get formatedDate {
    return formatter.format(date);
  }
}

//sums all category and expressed here
class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  //alternative constructor function
   ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses = allExpenses.where((expense) => expense.category==category).toList();

  //where -> allows to filter a list

  final Categories category;
  final List<Expense> expenses;

  //1 bucket / category
  double get totalExpenses {
    double sum = 0;

    //items in expenses, new item picked and stored in final variable expense
    //helps in access to the list
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
