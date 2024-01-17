import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/presentation/create_basket_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';

Future<void> showCreateBasketDialog(
    {required final BuildContext context, final Basket? basketToUpdate}) {
  return showDialog(
      context: context,
      builder: (context) =>
          _CreateBasketDialog(basketToUpdate: basketToUpdate));
}

class _CreateBasketDialog extends StatefulWidget {
  final Basket? basketToUpdate;

  const _CreateBasketDialog({this.basketToUpdate});

  @override
  State<_CreateBasketDialog> createState() => _CreateBasketPage();
}

class _CreateBasketPage extends PageState<CreateBasketViewState,
    _CreateBasketDialog, CreateBasketPresenter> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Basket? basketToUpdate = widget.basketToUpdate;
    if (basketToUpdate != null) {
      _nameController.text = basketToUpdate.name;
      _descriptionController.text = basketToUpdate.description ?? '';
      presenter.setBasket(basketToUpdate);
    }

    _nameController.addListener(() {
      presenter.onNameChanged(_nameController.text);
    });

    _descriptionController.addListener(() {
      presenter.onDescriptionChanged(_descriptionController.text);
    });
  }

  @override
  Widget buildWidget(BuildContext context, CreateBasketViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onBasketCreated?.consume((_) {
        Navigator.of(context).pop();
      });
    });

    return AlertDialog(
        title: Text('Create Basket',
            style: Theme.of(context).textTheme.titleMedium),
        actions: [
          ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              }),
          ElevatedButton(
            onPressed: snapshot.isValid()
                ? () {
                    presenter.createBasket(basketId: widget.basketToUpdate?.id);
                  }
                : null,
            child: widget.basketToUpdate != null
                ? const Text('Update')
                : const Text('Create'),
          ),
        ],
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _nameController,
              decoration: const InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.minPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _descriptionController,
              decoration: const InputDecoration(
                  labelText: 'Description', border: OutlineInputBorder()),
            ),
          ]),
        ));
  }

  @override
  CreateBasketPresenter initializePresenter() {
    return CreateBasketPresenter();
  }
}
