import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/models/expense_tag_vo.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/presentation/expense_tags_presenter.dart';
import 'package:wealth_wave/ui/widgets/create_expense_tag_dialog.dart';

class ExpenseTagsPage extends StatefulWidget {
  const ExpenseTagsPage({super.key});

  @override
  State<ExpenseTagsPage> createState() => _ExpenseTagsPage();
}

class _ExpenseTagsPage
    extends PageState<ExpenseTagsViewState, ExpenseTagsPage, ExpenseTagsPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchExpenseTags();
  }

  @override
  Widget buildWidget(
      final BuildContext context, final ExpenseTagsViewState snapshot) {
    List<ExpenseTagVO> expenseTags = snapshot.expenseTags;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tags'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
          child: ListView.builder(
        itemCount: expenseTags.length,
        itemBuilder: (context, index) {
          ExpenseTagVO expenseTag = expenseTags[index];
          return _expenseTagWidget(context: context, expenseTagVO: expenseTag);
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateExpenseTagDialog(context: context).then((value) {
            presenter.fetchExpenseTags();
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  ExpenseTagsPresenter initializePresenter() {
    return ExpenseTagsPresenter();
  }

  Widget _expenseTagWidget(
      {required final BuildContext context, required final ExpenseTagVO expenseTagVO}) {
    return Card(
        margin: const EdgeInsets.all(AppDimen.defaultPadding),
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.defaultPadding),
          child: OverflowBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              _getTitleWidget(expenseTagVO, context)
            ],
          ),
        ));
  }

  RichText _getTitleWidget(ExpenseTagVO expenseTagVO, BuildContext context) {
    List<WidgetSpan> widgets = [];
    widgets.add(WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: PopupMenuButton<int>(
        onSelected: (value) {
          if (value == 1) {
            showCreateExpenseTagDialog(
                    context: context, tagIdTOUpdate: expenseTagVO.id)
                .then((value) => presenter.fetchExpenseTags());
          } else if (value == 2) {
            presenter.deleteTag(id: expenseTagVO.id);
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Text('Edit'),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text('Delete'),
          ),
        ],
      ),
    ));
    return RichText(
        text: TextSpan(
            text: expenseTagVO.name,
            style: Theme.of(context).textTheme.titleMedium,
            children: widgets));
  }
}
