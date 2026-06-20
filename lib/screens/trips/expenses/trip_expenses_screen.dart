import 'package:flutter/material.dart';

import '../../../services/expenses/expense_service.dart';

class TripExpensesScreen
extends StatefulWidget {
final String tripName;

const TripExpensesScreen({
super.key,
required this.tripName,
});

@override
State<TripExpensesScreen>
createState() =>
_TripExpensesScreenState();
}

class _TripExpensesScreenState
extends State<TripExpensesScreen> {
final TextEditingController
titleController =
TextEditingController();

final TextEditingController
amountController =
TextEditingController();

final TextEditingController
paidByController =
TextEditingController();

List<Map<String, dynamic>>
expenses = [];

@override
void initState() {
super.initState();


expenses =
    ExpenseService.loadExpenses(
  widget.tripName,
);


}

Future<void> save() async {
await ExpenseService
.saveExpenses(
widget.tripName,
expenses,
);
}

Future<void> addExpense() async {
if (titleController.text
.trim()
.isEmpty ||
amountController.text
.trim()
.isEmpty) {
return;
}


setState(() {
  expenses.add({
    "title":
        titleController.text,
    "amount":
        double.tryParse(
              amountController
                  .text,
            ) ??
            0,
    "paidBy":
        paidByController.text,
  });
});

await save();

titleController.clear();
amountController.clear();
paidByController.clear();


}

Future<void> deleteExpense(
int index,
) async {
setState(() {
expenses.removeAt(index);
});


await save();


}

double get totalCost {
double total = 0;


for (final expense
    in expenses) {
  total +=
      (expense["amount"]
              as num)
          .toDouble();
}

return total;


}

@override
Widget build(
BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(
"${widget.tripName} Expenses",
),
backgroundColor:
Colors.green,
foregroundColor:
Colors.white,
),
body: Column(
children: [
Padding(
padding:
const EdgeInsets.all(
16),
child: Column(
children: [
TextField(
controller:
titleController,
decoration:
const InputDecoration(
labelText:
"Expense",
border:
OutlineInputBorder(),
),
),


            const SizedBox(
              height: 10,
            ),

            TextField(
              controller:
                  amountController,
              keyboardType:
                  TextInputType
                      .number,
              decoration:
                  const InputDecoration(
                labelText:
                    "Amount",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            TextField(
              controller:
                  paidByController,
              decoration:
                  const InputDecoration(
                labelText:
                    "Paid By",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width:
                  double.infinity,
              child:
                  ElevatedButton.icon(
                onPressed:
                    addExpense,
                icon:
                    const Icon(
                  Icons.add,
                ),
                label:
                    const Text(
                  "Add Expense",
                ),
              ),
            ),
          ],
        ),
      ),

      Card(
        margin:
            const EdgeInsets.all(
                12),
        color:
            Colors.green.shade50,
        child: Padding(
          padding:
              const EdgeInsets.all(
                  16),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            children: [
              const Text(
                "Total Cost",
                style:
                    TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              Text(
                "\$${totalCost.toStringAsFixed(2)}",
                style:
                    const TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),

      Expanded(
        child:
            ListView.builder(
          itemCount:
              expenses.length,
          itemBuilder:
              (
            context,
            index,
          ) {
            final expense =
                expenses[index];

            return Card(
              margin:
                  const EdgeInsets.symmetric(
                horizontal:
                    12,
                vertical: 6,
              ),
              child:
                  ListTile(
                leading:
                    const CircleAvatar(
                  child: Icon(
                    Icons
                        .attach_money,
                  ),
                ),
                title: Text(
                  expense["title"],
                ),
                subtitle:
                    Text(
                  "Paid by ${expense["paidBy"]}",
                ),
                trailing:
                    Row(
                  mainAxisSize:
                      MainAxisSize
                          .min,
                  children: [
                    Text(
                      "\$${expense["amount"]}",
                    ),
                    IconButton(
                      icon:
                          const Icon(
                        Icons
                            .delete,
                        color:
                            Colors.red,
                      ),
                      onPressed:
                          () =>
                              deleteExpense(
                        index,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  ),
);


}
}
