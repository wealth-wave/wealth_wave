import 'package:flutter/material.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/baskets_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';

class BasketsPage extends StatefulWidget {
  const BasketsPage({super.key});

  @override
  State<BasketsPage> createState() => _BasketsPage();
}

class _BasketsPage
    extends PageState<BasketsViewState, BasketsPage, BasketsPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchBaskets();
  }

  @override
  Widget buildWidget(
      final BuildContext context, final BasketsViewState snapshot) {
    List<BasketDO> baskets = snapshot.baskets;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: baskets.length,
        itemBuilder: (context, index) {
          BasketDO basket = baskets[index];
          return Card(
              child: ListTile(
            title: Text(basket.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showBasketNameDialog(context).then((value) {
                      if (value != null) {
                        presenter.updateBasketName(id: basket.id, name: value);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    presenter.deleteBasket(id: basket.id);
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
              presenter.createBasket(name: value);
            }
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  BasketsPresenter initializePresenter() {
    return BasketsPresenter();
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
            title: Text('Add Basket',
                style: Theme.of(context).textTheme.titleMedium),
            content: Padding(
                padding: const EdgeInsets.all(AppDimen.minPadding),
                child: TextFormField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(
                      labelText: "Basket Name", border: OutlineInputBorder()),
                )),
            actions: <Widget>[
              ElevatedButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    _textFieldController.clear();
                    Navigator.pop(context);
                  }),
              ElevatedButton(
                  onPressed: () {
                    var basketName = _textFieldController.text;
                    _textFieldController.clear();
                    if (basketName.isEmpty) {
                      return;
                    }
                    Navigator.pop(context, basketName);
                  },
                  child:
                      name == null ? const Text('Add') : const Text('Update')),
            ],
          );
        });
  }
}
