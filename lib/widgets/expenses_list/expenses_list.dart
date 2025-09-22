import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_expense_tracker/model/expense.dart';
import 'package:udemy_expense_tracker/widgets/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  //also passed to the parent for info
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder:
          (context, index) => Dismissible(
            background: Container(
              margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            //key helps ID the widgets make it unique
            key: ValueKey(expenses[index]),
            //dont care of the direction
            onDismissed: (direction) {

              //removed data based on the index
              onRemoveExpense(expenses[index]);
            },
            child: ExpenseItem(expenses[index]),
          ),
    );
  }
}
