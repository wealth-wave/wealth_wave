import 'package:flutter/material.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/investments_page_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/widgets/create_investment_dialog.dart';
import 'package:wealth_wave/ui/widgets/create_transaction_dialog.dart';
import 'package:wealth_wave/ui/widgets/view_transactions_dialog.dart';

class InvestmentsPage extends StatefulWidget {
  const InvestmentsPage({super.key});

  @override
  State<InvestmentsPage> createState() => _InvestmentsPage();
}

class _InvestmentsPage extends PageState<InvestmentsPageViewState,
    InvestmentsPage, InvestmentsPagePresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchInvestments();
  }

  @override
  Widget buildWidget(
      final BuildContext context, final InvestmentsPageViewState snapshot) {
    List<InvestmentEnriched> investments = snapshot.investments;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: investments.length,
        itemBuilder: (context, index) {
          InvestmentEnriched investment = investments[index];
          return Card(
              child: Padding(
                  padding: const EdgeInsets.all(AppDimen.minPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${investment.name} (${investment.basketName})'),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showCreateInvestmentDialog(
                                  context: context,
                                  investmentToUpdate: investment);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              presenter.deleteInvestment(id: investment.id);
                            },
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                showViewTransactionsDialog(
                                    context: context,
                                    investmentId: investment.id);
                              },
                              child: Text(
                                  '${investment.totalTransactions} transactions')),
                          IconButton(
                              onPressed: () {
                                showCreateTransactionDialog(
                                    context: context,
                                    investmentId: investment.id);
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                    ],
                  )));
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateInvestmentDialog(context: context)
              .then((value) => presenter.fetchInvestments());
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  InvestmentsPagePresenter initializePresenter() {
    return InvestmentsPagePresenter();
  }
}
