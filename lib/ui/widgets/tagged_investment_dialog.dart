import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/tagged_investment_presenter.dart';
import 'package:wealth_wave/ui/widgets/tag_investment_dialog.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showTaggedInvestmentDialog(
    {required final BuildContext context, required final int goalId}) {
  return showDialog(
      context: context,
      builder: (context) => _TaggedInvestmentWidget(
            goalId: goalId,
          ));
}

class _TaggedInvestmentWidget extends StatefulWidget {
  final int goalId;

  const _TaggedInvestmentWidget({required this.goalId});

  @override
  State<_TaggedInvestmentWidget> createState() => _TaggedInvestmentPage();
}

class _TaggedInvestmentPage extends PageState<TaggedInvestmentsViewState,
    _TaggedInvestmentWidget, TaggedInvestmentPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchTaggedInvestment();
  }

  @override
  Widget buildWidget(
      BuildContext context, TaggedInvestmentsViewState snapshot) {
    return AlertDialog(
      title: const Text('Investments'),
      content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.taggedInvestmentVOs.length,
            itemBuilder: (context, index) {
              TaggedInvestmentVO taggedInvestment =
                  snapshot.taggedInvestmentVOs.elementAt(index);
              return ListTile(
                title: Text(
                    '${formatToPercentage(taggedInvestment.split / 100)} of ${taggedInvestment.name}'),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showTagInvestmentDialog(
                              context: context,
                              idToUpdate: taggedInvestment.id,
                              goalId: widget.goalId,
                              investmentId: taggedInvestment.id,
                              sharePercentage: taggedInvestment.split)
                          .then((value) => presenter.fetchTaggedInvestment());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      presenter.deleteTaggedInvestment(
                          investmentId: taggedInvestment.id);
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
          child: const Text('Tag Investment'),
          onPressed: () {
            showTagInvestmentDialog(context: context, goalId: widget.goalId)
                .then((value) => presenter.fetchTaggedInvestment());
          },
        ),
      ],
    );
  }

  @override
  TaggedInvestmentPresenter initializePresenter() {
    return TaggedInvestmentPresenter(goalId: widget.goalId);
  }
}
