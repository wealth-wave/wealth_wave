import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/presentation/baskets_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/widgets/create_basket_dialog.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

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
    List<Basket> baskets = snapshot.baskets;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: baskets.length,
        itemBuilder: (context, index) {
          Basket basket = baskets[index];
          return _basketWidget(context: context, basket: basket);
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateBasketDialog(context: context).then((value) {
            presenter.fetchBaskets();
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

  Widget _basketWidget(
      {required final BuildContext context, required final Basket basket}) {
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
                      Text(basket.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      PopupMenuButton<int>(
                        onSelected: (value) {
                          if (value == 1) {
                            showCreateBasketDialog(
                                    basketToUpdate: basket, context: context)
                                .then((value) => presenter.fetchBaskets());
                          } else if (value == 2) {
                            presenter.deleteBasket(id: basket.id);
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  basket.description != null
                      ? Text(basket.description!,
                          style: Theme.of(context).textTheme.bodyMedium)
                      : Container(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(formatToCurrency(basket.totalValue),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(Invested Value)',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${basket.investmentCount}',
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('(Investments)',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
