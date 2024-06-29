import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/presentation/create_script_presenter.dart';

Future<void> showCreateScriptDialog(
    {required final BuildContext context, required final int investmentId}) {
  return showDialog(
      context: context,
      builder: (context) => _CreateScriptDialog(investmentId: investmentId));
}

class _CreateScriptDialog extends StatefulWidget {
  final int investmentId;

  const _CreateScriptDialog({required this.investmentId});

  @override
  State<_CreateScriptDialog> createState() => _CreateScriptPage();
}

class _CreateScriptPage extends PageState<CreateScriptViewState,
    _CreateScriptDialog, CreateScriptPresenter> {
  final _dslController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final viewState = presenter.getViewState();
    _dslController.text = viewState.dsl;

    presenter.fetchScript(investmentId: widget.investmentId);

    _dslController.addListener(() {
      presenter.onDSLChanged(_dslController.text);
    });
  }

  @override
  Widget buildWidget(BuildContext context, CreateScriptViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onScriptCreated?.consume((_) {
        Navigator.of(context).pop();
      });
      snapshot.onScriptDeleted?.consume((_) {
        Navigator.of(context).pop();
      });
      snapshot.onScriptLoaded?.consume((_) {
        _dslController.text = snapshot.dsl;
      });
    });

    return AlertDialog(
        title: Text('Script', style: Theme.of(context).textTheme.titleMedium),
        actions: [
          ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          ElevatedButton(
              child: const Text("Delete"),
              onPressed: () {
                presenter.deleteScript();
              }),
          ElevatedButton(
            onPressed: snapshot.isValid()
                ? () {
                    presenter.createScript();
                  }
                : null,
            child: const Text('Create'),
          ),
        ],
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextFormField(
              textInputAction: TextInputAction.newline,
              controller: _dslController,
              minLines: 5,
              maxLines: 50,
              autocorrect: false,
              decoration: const InputDecoration(
                  labelText: 'Script', border: OutlineInputBorder()),
            )
          ]),
        ));
  }

  @override
  CreateScriptPresenter initializePresenter() {
    return CreateScriptPresenter(investmentId: widget.investmentId);
  }
}
