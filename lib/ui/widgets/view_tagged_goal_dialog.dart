import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/presentation/tagged_goals_presenter.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showTaggedGoalDialog(
    {required final BuildContext context, required final int investmentId}) {
  return showDialog(
      context: context,
      builder: (context) => _TaggedGoalsWidget(
            investmentId: investmentId,
          ));
}

class _TaggedGoalsWidget extends StatefulWidget {
  final int investmentId;

  const _TaggedGoalsWidget({required this.investmentId});

  @override
  State<_TaggedGoalsWidget> createState() => _TaggedGoalsPage();
}

class _TaggedGoalsPage extends PageState<TaggedGoalsViewState,
    _TaggedGoalsWidget, TaggedGoalsPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchTaggedInvestment();
  }

  @override
  Widget buildWidget(BuildContext context, TaggedGoalsViewState snapshot) {
    return AlertDialog(
      title: const Text('Investments'),
      content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.taggedGoalVOs.length,
            itemBuilder: (context, index) {
              TaggedGoalVO taggedGoalVO =
                  snapshot.taggedGoalVOs.elementAt(index);
              return ListTile(
                  title: Text(
                      '${formatToCurrency(taggedGoalVO.currentValue)} (${formatToPercentage(taggedGoalVO.split)}) to ${taggedGoalVO.goalName}'));
            },
          )),
      actions: <Widget>[
        OutlinedButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  TaggedGoalsPresenter initializePresenter() {
    return TaggedGoalsPresenter(investmentId: widget.investmentId);
  }
}
