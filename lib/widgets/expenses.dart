import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_expense_tracker/widgets/chart/chart.dart';
import 'package:udemy_expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:udemy_expense_tracker/model/expense.dart';
import 'package:udemy_expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _resgisteredExpense = [
    Expense(
      title: 'Work',
      amount: 679,
      date: DateTime.now(),
      category: Categories.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 250,
      date: DateTime.now(),
      category: Categories.leisure,
    ),
  ];

  //takes expense value as Expense type for making list, as expense
  void _addExpense(Expense expense) {
    setState(() {
      //it is then added to the list of registered expense
      _resgisteredExpense.add(expense);
    });
  }

  //takes expense value as Expense type for removing list, as expense
  void _removeExpense(Expense expense) {
    //to get position of expenses before deleting
    //Index ID
    final expenseIndex = _resgisteredExpense.indexOf(expense);

    setState(() {
      //it is then removed from the list of registered expense
      _resgisteredExpense.remove(expense);
    });

    //step 1 clear existing snackbar
    ScaffoldMessenger.of(context).clearSnackBars();

    //step 2; show snack bars
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              //index - Element
              _resgisteredExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _onAddExpenseOveraly() {
    //onAddExpense takes same type of value as _add expense

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Content added yet, Start adding some!!!"),
    );

    if (_resgisteredExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _resgisteredExpense,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker", style: GoogleFonts.poppins()),
        actions: [
          IconButton(onPressed: _onAddExpenseOveraly, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [Chart(expenses: _resgisteredExpense), Expanded(child: mainContent)],
      ),
    );
  }
}
