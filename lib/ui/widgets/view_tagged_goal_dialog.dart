import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/tagged_goals_presenter.dart';
import 'package:wealth_wave/ui/widgets/create_tag_goal_dialog.dart';
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
              TagggedGoalVO taggedGoalVO =
                  snapshot.taggedGoalVOs.elementAt(index);
              return ListTile(
                title: Text(
                    '${formatToPercentage(taggedGoalVO.splitPercentage)} to ${taggedGoalVO.name}'),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showTagGoalDialog(
                              context: context,
                              goalId: taggedGoalVO.id,
                              investmentId: widget.investmentId,
                              sharePercentage: taggedGoalVO.splitPercentage)
                          .then((value) => presenter.fetchTaggedInvestment());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      presenter.deleteTaggedInvestment(goalId: taggedGoalVO.id);
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
          child: const Text('Tag Goal'),
          onPressed: () {
            showTagGoalDialog(
                    context: context, investmentId: widget.investmentId)
                .then((value) => presenter.fetchTaggedInvestment());
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
