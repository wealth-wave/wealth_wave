import 'package:flutter/material.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/view_state_holder.dart';

import '../utils/dialog_utils.dart';

abstract class PageState<D, T extends StatefulWidget, P extends Presenter<D>>
    extends State<T> {
  late P presenter;

  P initializePresenter();

  @override
  void initState() {
    super.initState();
    presenter = initializePresenter();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: presenter.getViewStateStream(),
        builder: (context, snapshot) {
          ViewStateHolder<D>? viewStateHolder = snapshot.data;
          if (viewStateHolder != null) {
            viewStateHolder.errorEvent?.consume((errorHolder) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                DialogUtils.showAppDialog(
                    context: context,
                    message: errorHolder.errorMessage,
                    onAction: errorHolder.onRetry);
              });
            });

            return buildWidget(context, viewStateHolder.viewState);
          }
          return const CircularProgressIndicator();
        });
  }

  Widget buildWidget(BuildContext context, D snapshot);

  @override
  void dispose() {
    super.dispose();
    presenter.onDestroy();
  }
}
