import 'package:flutter/material.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/investments_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/widgets/create_investment_dialog.dart';
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(investmentVO.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium)),
                  _infoToolTip(investmentVO, context),
                  PopupMenuButton<int>(
                    onSelected: (value) {
                      if (value == 1) {
                        showCreateInvestmentDialog(
                                context: context,
                                investmentIdToUpdate: investmentVO.id)
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
                  const Spacer(flex: 1),
                  TextButton(
                    onPressed: () {
                      showSipsDialog(
                              context: context, investmentId: investmentVO.id)
                          .then((value) => presenter.fetchInvestments());
                    },
                    child: Text('${investmentVO.sipCount} sips'),
                  ),
                  TextButton(
                    onPressed: () {
                      showTransactionsDialog(
                              context: context, investmentId: investmentVO.id)
                          .then((value) => presenter.fetchInvestments());
                    },
                    child: Text('${investmentVO.transactionCount} tx'),
                  ),
                  TextButton(
                    onPressed: () {
                      showTaggedGoalDialog(
                              context: context, investmentId: investmentVO.id)
                          .then((value) => presenter.fetchInvestments());
                    },
                    child: Text('${investmentVO.goalCount} goals'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(formatToCurrency(investmentVO.investedValue),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(Invested)',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(formatToPercentage(investmentVO.irr),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(IRR)',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(formatToCurrency(investmentVO.currentValue),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(Value)',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Tooltip _infoToolTip(InvestmentVO investmentVO, BuildContext context) {
    final description = investmentVO.description;
    final basketName = investmentVO.basketName;
    final List<Widget> widgets = [];
    if (description?.isNotEmpty == true) {
      widgets.add(Text(description ?? '',
          style: Theme.of(context).textTheme.labelSmall));
    }
    if (basketName != null) {
      widgets.add(Text('Basket: $basketName',
          style: Theme.of(context).textTheme.labelSmall));
    }
    widgets.add(Text('Risk: ${_getRiskLevel(investmentVO.riskLevel)}',
        style: Theme.of(context).textTheme.labelSmall));
    return Tooltip(
        richMessage: WidgetSpan(child: Column(children: widgets)),
        child: const Icon(Icons.info));
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
