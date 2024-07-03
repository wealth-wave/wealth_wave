import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/models/expense_vo.dart';
import 'package:wealth_wave/ui/presentation/monthly_expense_presenter.dart';
import 'package:wealth_wave/ui/widgets/create_expense_dialog.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showViewMonthlyExpensesDialog(
    {required final BuildContext context, required final DateTime monthDate}) {
  return showDialog(
      context: context,
      builder: (context) => _MonthlyExpensesDialog(
            monthDate: monthDate,
          ));
}

class _MonthlyExpensesDialog extends StatefulWidget {
  final DateTime monthDate;

  const _MonthlyExpensesDialog({required this.monthDate});

  @override
  State<_MonthlyExpensesDialog> createState() => _MonthlyExpensesPage();
}

class _MonthlyExpensesPage extends PageState<MonthlyExpenseViewState,
    _MonthlyExpensesDialog, MonthlyExpensePresenter> {
  @override
  void initState() {
    super.initState();
    presenter.getExpenses();
  }

  @override
  Widget buildWidget(BuildContext context, MonthlyExpenseViewState snapshot) {
    return AlertDialog(
      title: const Text('Expenses'),
      content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.expenses.length,
            itemBuilder: (context, index) {
              ExpenseVO expense = snapshot.expenses[index];
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(formatDate(expense.createdOn)),
                        const Text(' | '),
                        Text(expense.description ?? ''),
                      ],
                    ),
                    const SizedBox(
                        height: AppDimen.minPadding), // Add some spacing
                    Text('Amount: ${formatToCurrency(expense.amount)}'),
                  ],
                ),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showCreateExpenseDialog(
                              context: context, expenseIdTOUpdate: expense.id)
                          .then((value) => presenter.getExpenses());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      presenter.deleteExpense(id: expense.id);
                    },
                  )
                ]),
              );
            },
          )),
      actions: <Widget>[
        OutlinedButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        OutlinedButton(
          child: const Text('Add Expense'),
          onPressed: () {
            showCreateExpenseDialog(context: context)
                .then((value) => presenter.getExpenses());
          },
        ),
      ],
    );
  }

  @override
  MonthlyExpensePresenter initializePresenter() {
    return MonthlyExpensePresenter(monthDate: widget.monthDate);
  }
}
