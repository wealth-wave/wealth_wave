import 'package:flutter/material.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/investments_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/widgets/create_investment_dialog.dart';
import 'package:wealth_wave/ui/widgets/create_sip_dialog.dart';
import 'package:wealth_wave/ui/widgets/create_transaction_dialog.dart';
import 'package:wealth_wave/ui/widgets/view_sips_dialog.dart';
import 'package:wealth_wave/ui/widgets/view_tagged_goal_dialog.dart';
import 'package:wealth_wave/ui/widgets/view_transactions_dialog.dart';
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
    List<InvestmentVO> investmentVOs = snapshot.investmentVOs;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: investmentVOs.length,
        itemBuilder: (context, index) {
          InvestmentVO investmentVO = investmentVOs[index];
          return _investmentWidget(
              context: context, investmentVO: investmentVO);
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
      required final InvestmentVO investmentVO}) {
    return Card(
      margin: const EdgeInsets.all(AppDimen.defaultPadding),
      child: Padding(
        padding: const EdgeInsets.all(AppDimen.defaultPadding),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTitleWidget(investmentVO, context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    investmentVO.transactions.isEmpty
                        ? _getAddTransactionButton(context, investmentVO)
                        : TextButton(
                            onPressed: () {
                              showTransactionsDialog(
                                      context: context,
                                      investmentId: investmentVO.id)
                                  .then(
                                      (value) => presenter.fetchInvestments());
                            },
                            child: Text(
                                '${investmentVO.transactionCount} transactions'),
                          ),
                    investmentVO.sips.isEmpty
                        ? TextButton(
                            onPressed: () {
                              showCreateSipDialog(
                                      context: context,
                                      investmentId: investmentVO.id)
                                  .then(
                                      (value) => presenter.fetchInvestments());
                            },
                            child: const Text('Add SIP'),
                          )
                        : TextButton(
                            onPressed: () {
                              showSipsDialog(
                                      context: context,
                                      investmentId: investmentVO.id)
                                  .then(
                                      (value) => presenter.fetchInvestments());
                            },
                            child: Text('${investmentVO.sipCount} sips'),
                          ),
                    TextButton(
                      onPressed: () {
                        showTaggedGoalDialog(
                                context: context, investmentId: investmentVO.id)
                            .then((value) => presenter.fetchInvestments());
                      },
                      child: Text('${investmentVO.taggedGoalCount} goals'),
                    ),
                  ],
                ),
              ]),
          OverflowBar(
            children: [
              Column(
                children: [
                  Text(formatToCurrency(investmentVO.investedValue),
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text('(Invested)',
                      style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
              const Padding(padding: EdgeInsets.all(AppDimen.defaultPadding)),
              Column(
                children: [
                  Text(formatToCurrency(investmentVO.currentValue),
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text('(At ${formatToPercentage(investmentVO.irr)}',
                      style: Theme.of(context).textTheme.labelSmall),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }

  Widget _getAddTransactionButton(
      BuildContext context, InvestmentVO investmentVO) {
    if (investmentVO.investedValue > 0) {
      return TextButton(
        onPressed: () {
          showCreateTransactionDialog(
                  context: context, investmentId: investmentVO.id)
              .then((value) => presenter.fetchInvestments());
        },
        child: const Text('Add transactions'),
      );
    } else {
      return FilledButton(
        onPressed: () {
          showCreateTransactionDialog(
                  context: context, investmentId: investmentVO.id)
              .then((value) => presenter.fetchInvestments());
        },
        child: const Text('Add transactions'),
      );
    }
  }

  RichText _getTitleWidget(InvestmentVO investmentVO, BuildContext context) {
    List<WidgetSpan> widgets = [];
    String? basketName = investmentVO.basketName;
    if (basketName != null) {
      widgets.add(WidgetSpan(
          child: Text(' | $basketName',
              style: Theme.of(context).textTheme.labelMedium)));
    }
    widgets.add(WidgetSpan(
        child: Text(' | ${_getRiskLevel(investmentVO.riskLevel)}',
            style: Theme.of(context).textTheme.labelMedium)));
    widgets.add(WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: PopupMenuButton<int>(
        onSelected: (value) {
          if (value == 1) {
            showCreateInvestmentDialog(
                    context: context, investmentIdToUpdate: investmentVO.id)
                .then((value) => presenter.fetchInvestments());
          } else if (value == 2) {
            presenter.deleteInvestment(id: investmentVO.id);
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
            text: investmentVO.name,
            style: Theme.of(context).textTheme.titleMedium,
            children: widgets));
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
