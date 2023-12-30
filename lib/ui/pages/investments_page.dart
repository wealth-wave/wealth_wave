import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/presentation/investments_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/widgets/create_investment_dialog.dart';
import 'package:wealth_wave/ui/widgets/create_transaction_dialog.dart';
import 'package:wealth_wave/ui/widgets/transactions_dialog.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

class InvestmentsPage extends StatefulWidget {
  const InvestmentsPage({super.key});

  @override
  State<InvestmentsPage> createState() => _InvestmentsPage();
}

class _InvestmentsPage extends PageState<InvestmentsViewState, InvestmentsPage,
    InvestmentsPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchInvestments();
  }

  @override
  Widget buildWidget(
      final BuildContext context, final InvestmentsViewState snapshot) {
    List<Investment> investments = snapshot.investments;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: investments.length,
        itemBuilder: (context, index) {
          Investment investment = investments[index];
          double? irr = investment.getIrr();
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
                                showTransactionsDialog(
                                        context: context,
                                        investmentId: investment.id)
                                    .then((value) =>
                                        presenter.fetchInvestments());
                              },
                              child: Text(
                                  '${investment.totalTransactions} transactions')),
                          IconButton(
                              onPressed: () {
                                showCreateTransactionDialog(
                                        context: context,
                                        investmentId: investment.id)
                                    .then((value) =>
                                        presenter.fetchInvestments());
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Invested'),
                              Text('${investment.totalInvestedAmount}'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Current Value'),
                              Text('${investment.value}'),
                              Text(
                                formatDate(investment.valueUpdatedOn),
                                style: Theme.of(context).textTheme.labelMedium,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Growth'),
                              Text(irr != null ? formatToPercentage(irr) : '-'),
                            ],
                          ),
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
  InvestmentsPresenter initializePresenter() {
    return InvestmentsPresenter();
  }
}
