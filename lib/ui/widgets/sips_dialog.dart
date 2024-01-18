import 'package:flutter/material.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/sips_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/widgets/create_sip_dialog.dart';
import 'package:wealth_wave/ui/widgets/create_transaction_dialog.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showSipsDialog(
    {required final BuildContext context, required final int investmentId}) {
  return showDialog(
      context: context,
      builder: (context) => _SipsDialog(
            investmentId: investmentId,
          ));
}

class _SipsDialog extends StatefulWidget {
  final int investmentId;

  const _SipsDialog({required this.investmentId});

  @override
  State<_SipsDialog> createState() => _SipsPage();
}

class _SipsPage extends PageState<SipsViewState, _SipsDialog, SipsPresenter> {
  @override
  void initState() {
    super.initState();

    presenter.getSips();
  }

  @override
  Widget buildWidget(BuildContext context, SipsViewState snapshot) {
    return AlertDialog(
      title: const Text('Transactions'),
      content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.sips.length,
            itemBuilder: (context, index) {
              SipDO sip = snapshot.sips[index];
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(formatDate(sip.startDate)),
                        const Text(' | '),
                        Text(sip.description ?? ''),
                      ],
                    ),
                    const SizedBox(
                        height: AppDimen.minPadding), // Add some spacing
                    Text('Amount: ${formatToCurrency(sip.amount)}'),
                  ],
                ),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showCreateSipDialog(
                              context: context,
                              investmentId: widget.investmentId,
                              sipToUpdate: sip)
                          .then((value) => presenter.getSips());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      presenter.deleteSip(id: sip.id);
                    },
                  )
                ]),
              );
            },
          )),
      actions: <Widget>[
        OutlinedButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        OutlinedButton(
          child: const Text('Add Transaction'),
          onPressed: () {
            showCreateTransactionDialog(
                    context: context, investmentId: widget.investmentId)
                .then((value) =>
                    presenter.getSips(investmentId: widget.investmentId));
          },
        ),
      ],
    );
  }

  @override
  SipsPresenter initializePresenter() {
    return SipsPresenter(widget.investmentId);
  }
}
