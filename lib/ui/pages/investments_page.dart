import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/investments_page_presenter.dart';
import 'package:wealth_wave/ui/nav_path.dart';

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
              child: ListTile(
            title: Text(investment.investment.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        NavPath.updateBasket(id: investment.investment.id));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    presenter.deleteInvestment(id: investment.investment.id);
                  },
                ),
              ],
            ),
          ));
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBasketNameDialog(context).then((value) {
            if (value != null) {
              Navigator.of(context).pushNamed(NavPath.createInvestment);
            }
          });
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

  final _textFieldController = TextEditingController();

  Future<String?> _showBasketNameDialog(BuildContext context,
      {String? name}) async {
    if (name != null) {
      _textFieldController.text = name;
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Basket'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Basket Name"),
            ),
            actions: <Widget>[
              ElevatedButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    _textFieldController.clear();
                    Navigator.pop(context);
                  }),
              ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    var name = _textFieldController.text;
                    _textFieldController.clear();
                    Navigator.pop(context, name);
                  }),
            ],
          );
        });
  }
}
