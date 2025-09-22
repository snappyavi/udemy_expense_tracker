import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_expense_tracker/model/expense.dart';

final formatter = DateFormat.yMd();
//also available in expense.dart file

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // const _NewExpenseState({Super.key,});

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  //either stores a value of date time or null
  DateTime? _selectedDate;

  //default category
  Categories _selectedCategory = Categories.leisure;

  //date picker method for date icon button
  //easy peasy
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    //wait for the future value to be received when clicked on icon
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    //once the date is selected store it in _selectedDate
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  //for submiting the data; Saving it
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    //tryParse will yeild null
    //or operator || combines the conditions
    //if one of them is met, the amountisInvalid is true
    final amountIsInvalid = enteredAmount == null || enteredAmount < 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text("Invalid Input"),
              content: Text(
                "Please ensure a valid title, amount, date or category was entered",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx); //ctx is context of showDialog
                  },
                  child: Text('Roger that 👍'),
                ),
              ],
            ),
      );

      return; //no code executed after this; if we make it in this statement
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Expanded(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       TextField(
          //         //trigger when the values are changed
          //         maxLength: 50,
          //         decoration: InputDecoration(
          //           label: Text(
          //             'Add Expense',
          //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          TextField(
            //trigger when the values are changed
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  //trigger when the values are changed
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    prefixText: "\₹", //for currency
                    label: Text('Amount'),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //show date if selected or no date selected if not
                    Text(
                      _selectedDate == null
                          ? 'Not Selected yet'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16),
          Row(
            children: [
              //drop down menu item takes List
              // The catgories that is a list of all values is coverted by To List
              //but it needs item so we convert using map
              //dropdownmenuItem is returned; it takes a child text
              //category is of type Category
              DropdownButton(
                //to display the default value n show the selected
                value: _selectedCategory,
                items:
                    Categories.values
                        .map(
                          (category) => DropdownMenuItem(
                            //value stored inside
                            value: category,
                            //value visible to the user
                            child: Text(category.name.toUpperCase().toString()),
                          ),
                        )
                        .toList(),
                //dynamic and values selected by user
                onChanged: (value) {
                  //null check
                  if (value == null) {
                    return;
                  }
                  //if values found, the default is replaced
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
