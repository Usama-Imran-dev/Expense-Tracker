import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:project4/Model/expense.dart';

final formatter = DateFormat.yMd();

class Newexpense extends StatefulWidget {
  const Newexpense(this.AddExpense, {super.key});
  // ignore: non_constant_identifier_names
  final void Function(Expense expense) AddExpense;

  @override
  State<Newexpense> createState() => _NewexpenseState();
}

class _NewexpenseState extends State<Newexpense> {
  // var entertitle = "";
  // void savetitleinput(String inputvalue) {
  //   entertitle = inputvalue;
  // }
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime?
      selecteddate; //? it tell that selecteddate store value of datetime or it will be null

  Category selectedcategory = Category.leisure;

  void presentdatepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final pickeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);
    setState(() {
      selecteddate = pickeddate;
    });
  }

  void showDialogbox() {
    // if (Platform.isIOS) {
    //   showCupertinoDialog(
    //       context: context,
    //       builder: (ctx) {
    //         return CupertinoAlertDialog(
    //           title: const Text('invalid input'),
    //           content: const Text(
    //               'please make sure a valid title amount and category was entered!'),
    //           actions: [
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.pop(ctx);
    //                 },
    //                 child: const Text('OK!'))
    //           ],
    //         );
    //       });
    // } else {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('invalid input'),
            content: const Text(
                'please make sure a valid title amount and category was entered!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('OK!'))
            ],
          );
        });
    //}
  }

  void submitexpensedata() {
    final enteramount = double.tryParse(amountcontroller
        .text); //tryparse('heelo) -> null tryparse(1.12) -> 1.12
    final amountisinvalid = enteramount == null || enteramount <= 0;
    if (titlecontroller.text.trim().isEmpty ||
        amountisinvalid ||
        selecteddate == null) {
      //show erroe message
      showDialogbox();

      return;
    }

    widget.AddExpense(Expense(
        titlecontroller.text, enteramount, selecteddate!, selectedcategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspacing = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 50, 16, keyboardspacing + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                            //onChanged: savetitleinput,
                            controller: titlecontroller,
                            maxLength: 50,
                            decoration: const InputDecoration(
                                label: Text('title'), hintText: 'title')),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                            //onChanged: savetitleinput,
                            controller: amountcontroller,
                            keyboardType: TextInputType.number,
                            maxLength: 50,
                            decoration: const InputDecoration(
                                label: Text('Amount'),
                                prefixText: '\$',
                                hintText: 'Amount')),
                      ),
                    ],
                  )
                else
                  TextField(
                      //onChanged: savetitleinput,
                      controller: titlecontroller,
                      maxLength: 50,
                      decoration: const InputDecoration(
                          label: Text('title'), hintText: 'title')),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: selectedcategory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              selectedcategory = value;
                            });
                          }),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(selecteddate == null
                                ? 'selected Date'
                                : formatter.format(
                                    selecteddate!)), // tell flutter selected date cannot be null
                            IconButton(
                                onPressed: presentdatepicker,
                                icon: const Icon(Icons.calendar_month))
                          ],
                        ),
                      )
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                          //onChanged: savetitleinput,
                          controller: amountcontroller,
                          keyboardType: TextInputType.number,
                          maxLength: 50,
                          decoration: const InputDecoration(
                              label: Text('Amount'),
                              prefixText: '\$',
                              hintText: 'Amount')),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(selecteddate == null
                              ? 'selected Date'
                              : formatter.format(
                                  selecteddate!)), // tell flutter selected date cannot be null
                          IconButton(
                              onPressed: presentdatepicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          onPressed: submitexpensedata,
                          child: const Text('Save Expense')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: selectedcategory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              selectedcategory = value;
                            });
                          }),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: submitexpensedata,
                          child: const Text('Save Expense')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
