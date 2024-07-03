import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/presentation/create_expense_tag_presenter.dart';

Future<void> showCreateExpenseTagDialog(
    {required final BuildContext context, final int? tagIdTOUpdate}) {
  return showDialog(
      context: context,
      builder: (context) =>
          _CreateExpenseTagDialog(tagIdTOUpdate: tagIdTOUpdate));
}

class _CreateExpenseTagDialog extends StatefulWidget {
  final int? tagIdTOUpdate;

  const _CreateExpenseTagDialog({this.tagIdTOUpdate});

  @override
  State<_CreateExpenseTagDialog> createState() => _CreateExpenseTagPage();
}

class _CreateExpenseTagPage extends PageState<CreateExpenseTagViewState,
    _CreateExpenseTagDialog, CreateExpenseTagPresenter> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final viewState = presenter.getViewState();
    _nameController.text = viewState.name;
    _descriptionController.text = viewState.description;

    int? tagIdToUpdate = widget.tagIdTOUpdate;
    if (tagIdToUpdate != null) {
      presenter.fetchExpenseTag(id: tagIdToUpdate);
    }

    _nameController.addListener(() {
      presenter.onNameChanged(_nameController.text);
    });

    _descriptionController.addListener(() {
      presenter.onDescriptionChanged(_descriptionController.text);
    });
  }

  @override
  Widget buildWidget(BuildContext context, CreateExpenseTagViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onTagCreated?.consume((_) {
        Navigator.of(context).pop();
      });
      snapshot.onTagFetched?.consume((_) {
        _nameController.text = snapshot.name;
        _descriptionController.text = snapshot.description;
      });
    });

    return AlertDialog(
        title: Text('Create Tag',
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
                    presenter.createExpenseTag(idToUpdate: widget.tagIdTOUpdate);
                  }
                : null,
            child: widget.tagIdTOUpdate != null
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
  CreateExpenseTagPresenter initializePresenter() {
    return CreateExpenseTagPresenter();
  }
}
