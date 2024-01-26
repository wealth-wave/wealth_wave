import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
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
    List<BasketVO> basketVOs = snapshot.baskets;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: basketVOs.length,
        itemBuilder: (context, index) {
          BasketVO basketVO = basketVOs[index];
          return _basketWidget(context: context, basketVO: basketVO);
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
      {required final BuildContext context, required final BasketVO basketVO}) {
    return Card(
        margin: const EdgeInsets.all(AppDimen.defaultPadding),
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.defaultPadding),
          child: OverflowBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              _getTitleWidget(basketVO, context),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(formatToCurrency(basketVO.totalInvestedAmount)),
                ],
              )
            ],
          ),
        ));
  }

  RichText _getTitleWidget(BasketVO basketVO, BuildContext context) {
    List<WidgetSpan> widgets = [];
    widgets.add(WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: PopupMenuButton<int>(
        onSelected: (value) {
          if (value == 1) {
            showCreateBasketDialog(
                    context: context, basketIdTOUpdate: basketVO.id)
                .then((value) => presenter.fetchBaskets());
          } else if (value == 2) {
            presenter.deleteBasket(id: basketVO.id);
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
            text: basketVO.name,
            style: Theme.of(context).textTheme.titleMedium,
            children: widgets));
  }
}
