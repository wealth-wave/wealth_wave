import 'package:wealth_wave/core/presenter.dart';

class DashboardPagePresenter extends Presenter<DashboardPageViewState> {
  DashboardPagePresenter() : super(DashboardPageViewState());

  void fetchDashboardInfo() {
    updateViewState((viewState) {
      viewState.isLoading = true;
    });

    //TODO call use case to fetch data and then update view state
  }
}

class DashboardPageViewState {
  bool isLoading = false;

  DashboardPageViewState({this.isLoading = false});
}
