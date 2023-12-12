import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/dashboard_page_presenter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static bool isMatchingPath(String path) {
    var uri = Uri.parse(path);
    return uri.pathSegments.isEmpty;
  }

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends PageState<DashboardPageViewState,
    DashboardPage, DashboardPagePresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchDashboardInfo();
  }

  @override
  Widget buildWidget(BuildContext context, DashboardPageViewState snapshot) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Wealth Wave"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  DashboardPagePresenter initializePresenter() {
    return DashboardPagePresenter();
  }
}
