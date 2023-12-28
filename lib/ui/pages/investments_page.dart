import 'package:flutter/material.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/investments_page_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/nav_path.dart';
import 'package:wealth_wave/ui/widgets/create_investment_dialog.dart';

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
    List<InvestmentVO> investments = snapshot.investments;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: investments.length,
        itemBuilder: (context, index) {
          InvestmentVO investment = investments[index];
          return Card(
              child: Padding(
                  padding: const EdgeInsets.all(AppDimen.minPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              '${investment.investment.name} (${investment.basket.name})'),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  NavPath.updateInvestment(
                                      id: investment.investment.id));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              presenter.deleteInvestment(
                                  id: investment.investment.id);
                            },
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                  '${investment.transactions.length} transactions')),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.add))
                        ],
                      ),
                    ],
                  )));
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateInvestmentDialog(context: context);
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getTransactionItemWidget(InvestmentTransaction transaction) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [],
    );
  }

  @override
  InvestmentsPagePresenter initializePresenter() {
    return InvestmentsPagePresenter();
  }
}
