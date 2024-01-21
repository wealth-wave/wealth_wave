import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/main_presenter.dart';
import 'package:wealth_wave/ui/pages/baskets_page.dart';
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
  Widget buildWidget(BuildContext context, MainViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onImportCompleted?.consume((p0) {
        DialogUtils.showAppDialog(context: context, message: "Import complete");
      });
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Wealth Wave"),
          actions: [
            PopupMenuButton<int>(
              onSelected: (value) {
                if (value == 1) {
                  presenter.performBackup();
                } else if (value == 2) {
                  presenter.performImportFile();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Export'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Import'),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on),
              label: 'Investments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flag),
              label: 'Goals',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              label: 'Baskets',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: Builder(
          builder: (context) {
            switch (_selectedIndex) {
              case 0:
                return const InvestmentsPage();
              case 1:
                return const GoalsPage();
              case 2:
                return const BasketsPage();
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
