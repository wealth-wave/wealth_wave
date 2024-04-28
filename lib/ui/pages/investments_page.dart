import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/investments_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/widgets/create_investment_dialog.dart';
import 'package:wealth_wave/ui/widgets/create_script_dialog.dart';
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
  final TextEditingController _searchController = TextEditingController();
  bool _showFab = true;

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
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search investments',
          ),
          onChanged: (value) {
            presenter.filterByName(value);
          },
        ),
        actions: [
          PopupMenuButton<SortBy>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              presenter.sortBy(sortBy: value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: SortBy.name,
                child: Text('Sort by Name'),
              ),
              const PopupMenuItem(
                value: SortBy.value,
                child: Text('Sort by Value'),
              ),
              const PopupMenuItem(
                value: SortBy.irr,
                child: Text('Sort by IRR'),
              ),
            ],
          ),
        ],
      ),
      body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.reverse) {
              if (_showFab) {
                setState(() {
                  _showFab = false;
                });
              }
            } else if (notification.direction == ScrollDirection.forward) {
              if (!_showFab) {
                setState(() {
                  _showFab = true;
                });
              }
            }
            return true;
          },
          child: Center(
              child: ListView.builder(
            itemCount: investmentVOs.length,
            itemBuilder: (context, index) {
          InvestmentVO investmentVO = investmentVOs[index];
          return _investmentWidget(
              context: context, investmentVO: investmentVO);
        },
          ))),
      floatingActionButton: _showFab
          ? FloatingActionButton(
              onPressed: () {
                showCreateInvestmentDialog(context: context)
              .then((value) => presenter.fetchInvestments());
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
            )
          : null,
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
                    Text(
                      ('Qty ${NumberFormat.compact().format(investmentVO.qty)}'),
                    ),
                  ],
                ),
              ]),
          OverflowBar(
            children: [
              _getScriptWidget(investmentVO),
              const Padding(padding: EdgeInsets.all(AppDimen.defaultPadding)),
              _getInvestedWidget(investmentVO, context),
              const Padding(padding: EdgeInsets.all(AppDimen.defaultPadding)),
              _getValueWidget(investmentVO, context),
              const Padding(padding: EdgeInsets.all(AppDimen.defaultPadding)),
            ],
          )
        ]),
      ),
    );
  }

  Column _getInvestedWidget(InvestmentVO investmentVO, BuildContext context) {
    return Column(
      children: [
        Text(formatToCurrency(investmentVO.investedValue),
            style: Theme.of(context).textTheme.bodyLarge),
        Text('(Invested)', style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }

  Column _getValueWidget(InvestmentVO investmentVO, BuildContext context) {
    Color color = Colors.red;
    if (investmentVO.currentValue > investmentVO.investedValue) {
      color = Colors.green;
    }
    return Column(
      children: [
        Text(formatToCurrency(investmentVO.currentValue),
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(color: color)),
        Text('(At ${formatToPercentage(investmentVO.irr)})',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: color)),
      ],
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
            showCreateScriptDialog(
                    context: context, investmentId: investmentVO.id)
                .then((value) =>
                    presenter.updateValue(investmentId: investmentVO.id));
          } else if (value == 3) {
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
            child: Text('Script'),
          ),
          const PopupMenuItem(
            value: 3,
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
      case RiskLevel.veryLow:
        return 'Very Low';
      case RiskLevel.low:
        return 'Low';
      case RiskLevel.medium:
        return 'Medium';
      case RiskLevel.high:
        return 'High';
      case RiskLevel.veryHigh:
        return 'Very High';
    }
  }

  Widget _getScriptWidget(InvestmentVO investmentVO) {
    return investmentVO.hasScript
        ? IconButton(
            onPressed: () =>
                presenter.updateValue(investmentId: investmentVO.id),
            icon: const Icon(Icons.code, color: Colors.green))
        : const Text('');
  }
}
