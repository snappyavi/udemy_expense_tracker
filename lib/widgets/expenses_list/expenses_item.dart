import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  //{named parameter} vs positional parameter or say arguments

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.titleLarge,),
            SizedBox(height: 4),
            Row(
              children: [
                Text('\₹${expense.amount.toString()}'),
                //group category and dat
                Spacer(),
                Row(
                  children: [
                    //icons take category icons from expense model and it takes
                    //expense.Category to point to the icons we need from expenses.dart
                    Icon(CategoryIcons[expense.category]),
                    SizedBox(width: 16),
                    //we call the formatted date option directly
                    Text(expense.formatedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
