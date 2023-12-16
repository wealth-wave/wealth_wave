import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/presentation/baskets_page_presenter.dart';
import 'package:wealth_wave/ui/nav_path.dart';

class BasketsPage extends StatefulWidget {
  const BasketsPage({super.key});

  @override
  State<BasketsPage> createState() => _BasketsPage();
}

class _BasketsPage
    extends PageState<BasketsPageViewState, BasketsPage, BasketsPagePresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchBaskets();
  }

  @override
  Widget buildWidget(
      final BuildContext context, final BasketsPageViewState snapshot) {
    List<Basket> baskets = snapshot.baskets;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: baskets.length,
        itemBuilder: (context, index) {
          Basket basket = baskets[index];
          return Card(
              child: ListTile(
            title: Text(basket.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(NavPath.updateBasket(id: basket.id));
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
          Navigator.of(context).pushNamed(NavPath.createBasket);
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  BasketsPagePresenter initializePresenter() {
    return BasketsPagePresenter();
  }
}
