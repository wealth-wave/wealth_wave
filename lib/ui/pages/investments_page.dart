import 'package:flutter/material.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/presentation/investments_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/widgets/create_investment_dialog.dart';
import 'package:wealth_wave/ui/widgets/tagged_goal_dialog.dart';
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
          return _investmentWidget(context: context, investment: investment);
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

  Widget _investmentWidget(
      {required final BuildContext context,
      required final Investment investment}) {
    double? irr = investment.getIrr();
    return Card(
        margin: const EdgeInsets.all(AppDimen.defaultPadding),
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.defaultPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(investment.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('(${investment.basketName})'),
                      const Text(' | '),
                      Text('${_getRiskLevel(investment.riskLevel)} Risk',
                          style: Theme.of(context).textTheme.labelSmall),
                      PopupMenuButton<int>(
                        onSelected: (value) {
                          if (value == 1) {
                            showCreateInvestmentDialog(
                                    context: context,
                                    investmentToUpdate: investment)
                                .then((value) => presenter.fetchInvestments());
                          } else if (value == 2) {
                            presenter.deleteInvestment(id: investment.id);
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          showTransactionsDialog(
                                  context: context, investmentId: investment.id)
                              .then((value) => presenter.fetchInvestments());
                        },
                        child: Text(
                            '${investment.transactions.length} transactions'),
                      ),
                      TextButton(
                        onPressed: () {
                          showTaggedGoalDialog(
                                  context: context, investmentId: investment.id)
                              .then((value) => presenter.fetchInvestments());
                        },
                        child: Text(
                            '${investment.taggedGoals.length} tagged goals'),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(formatToCurrency(investment.totalInvestedAmount),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(Invested Amount)',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(irr != null ? formatToPercentage(irr) : '-',
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(Growth Per Yearl)',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(formatToCurrency(investment.value),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(
                          '(Value on ${formatDate(investment.valueUpdatedOn)})',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  String _getRiskLevel(RiskLevel riskLevel) {
    switch (riskLevel) {
      case RiskLevel.low:
        return 'Low';
      case RiskLevel.medium:
        return 'Medium';
      case RiskLevel.high:
        return 'High';
    }
  }
}
