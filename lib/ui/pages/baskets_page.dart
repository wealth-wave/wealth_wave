import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/presentation/baskets_page_presenter.dart';

class BasketsPage extends StatefulWidget {
  const BasketsPage({super.key});

  @override
  State<BasketsPage> createState() => _BasketsPage();
}

class _BasketsPage
    extends PageState<BasketsPageViewState, BasketsPage, BasketsPagePresenter> {
  @override
  Widget buildWidget(BuildContext context, BasketsPageViewState snapshot) {
    List<Basket> baskets = snapshot.baskets;
    return Scaffold(
      body: ListView.builder(
        itemCount: baskets.length,
        itemBuilder: (context, index) {
          Basket basket = baskets[index];
          return ListTile(title: Text(basket.name));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
