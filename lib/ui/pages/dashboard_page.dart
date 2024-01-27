import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/dashboard_presenter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage
    extends PageState<DashboardViewState, DashboardPage, DashboardPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchDashboard();
  }

  @override
  Widget buildWidget(
      final BuildContext context, final DashboardViewState snapshot) {
    return Scaffold(body: Center());
  }

  @override
  DashboardPresenter initializePresenter() {
    return DashboardPresenter();
  }
}
