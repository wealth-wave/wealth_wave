import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/nav_path.dart';
import 'package:wealth_wave/ui/pages/expense_page.dart';
import 'package:wealth_wave/ui/presentation/main_presenter.dart';
import 'package:wealth_wave/ui/pages/dashboard_page.dart';
import 'package:wealth_wave/ui/pages/goals_page.dart';
import 'package:wealth_wave/ui/pages/investments_page.dart';
import 'package:wealth_wave/utils/dialog_utils.dart';

class MainPage extends StatefulWidget {
  final List<String> path;

  const MainPage({super.key, required this.path});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends PageState<MainViewState, MainPage, MainPresenter> {
  var _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    presenter.performSync();
  }

  @override
  Widget buildWidget(BuildContext context, MainViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onImportCompleted?.consume((p0) {
        DialogUtils.showAppDialog(context: context, message: "Import complete");
      });
    });

    if (snapshot.contentLoading) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Wealth Wave"),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Wealth Wave"),
          actions: [
            PopupMenuButton<int>(
              onSelected: (value) {
                if (value == 1) {
                  Navigator.of(context).pushNamed(NavPath.baskets);
                } else if (value == 2) {
                  Navigator.of(context).pushNamed(NavPath.expenseTags);
                } else if (value == 3) {
                  Navigator.of(context).pushNamed(NavPath.upcomingSips);
                } else if (value == 4) {
                  presenter.performBackup();
                } else if (value == 5) {
                  presenter.performImportFile();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Baskets'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Expense Tags'),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text('Upcoming Sips'),
                ),
                const PopupMenuItem(
                  value: 4,
                  child: Text('Export'),
                ),
                const PopupMenuItem(
                  value: 5,
                  child: Text('Import'),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.analytics),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.monetization_on),
              label: 'Investments',
            ),
            NavigationDestination(
              icon: Icon(Icons.flag),
              label: 'Goals',
            ),
            NavigationDestination(
              icon: Icon(Icons.money_rounded),
              label: 'Expenses',
            )
          ],
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: Builder(
          builder: (context) {
            switch (_selectedIndex) {
              case 0:
                return const DashboardPage();
              case 1:
                return const InvestmentsPage();
              case 2:
                return const GoalsPage();
              case 3:
                return const ExpensePage();
              default:
                return Container();
            }
          },
        ));
  }

  @override
  MainPresenter initializePresenter() {
    return MainPresenter();
  }
}
