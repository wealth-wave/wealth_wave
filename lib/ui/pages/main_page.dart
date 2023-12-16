import 'package:flutter/material.dart';
import 'package:wealth_wave/ui/pages/baskets_page.dart';
import 'package:wealth_wave/ui/pages/goals_page.dart';

class MainPage extends StatefulWidget {
  final List<String> path;

  const MainPage({super.key, required this.path});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Wealth Wave"),
        ),
        body: SafeArea(
          child: Row(
            children: [
              NavigationRail(
                  extended: true,
                  onDestinationSelected: (value) {
                    setState(() {
                      _selectedIndex = value;
                    });
                  },
                  destinations: const [
                    NavigationRailDestination(
                        icon: Icon(Icons.dashboard), label: Text('Dashboard')),
                    NavigationRailDestination(
                        icon: Icon(Icons.bookmark), label: Text('Goals')),
                    NavigationRailDestination(
                        icon: Icon(Icons.monetization_on),
                        label: Text('Investment')),
                    NavigationRailDestination(
                        icon: Icon(Icons.local_offer), label: Text('Baskets')),
                  ],
                  selectedIndex: _selectedIndex),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: Builder(
                  builder: (context) {
                    switch (_selectedIndex) {
                      case 0:
                        return Container();
                      case 1:
                        return const GoalsPage();
                      case 2:
                        return Container();
                      case 4:
                        return const BasketsPage();
                      default:
                        return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class SideNav extends StatelessWidget {
  final Function setIndex;
  final int selectedIndex;

  const SideNav(this.selectedIndex, this.setIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Wealth Wave',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 21)),
          ),
          _navItem(context, Icons.move_to_inbox, 'Dashboard', onTap: () {
            _navItemClicked(context, 0);
          }, selected: selectedIndex == 0),
          _navItem(context, Icons.move_to_inbox, 'Goals', onTap: () {
            _navItemClicked(context, 1);
          }, selected: selectedIndex == 1),
          _navItem(context, Icons.inbox, 'Investment', onTap: () {
            _navItemClicked(context, 2);
          }, selected: selectedIndex == 2),
          _navItem(context, Icons.group, 'Expenses', onTap: () {
            _navItemClicked(context, 3);
          }, selected: selectedIndex == 3),
          _navItem(context, Icons.local_offer, 'Manage Baskets', onTap: () {
            _navItemClicked(context, 4);
          }, selected: selectedIndex == 4),
        ],
      ),
    );
  }

  _navItem(BuildContext context, IconData icon, String text,
          {Text suffix = const Text(""),
          required Function onTap,
          bool selected = false}) =>
      Container(
        color: selected ? Colors.grey.shade300 : Colors.transparent,
        child: ListTile(
          leading: Icon(icon,
              color: selected ? Theme.of(context).primaryColor : Colors.black),
          trailing: suffix,
          title: Text(text),
          selected: selected,
          onTap: () => {onTap()},
        ),
      );

  _navItemClicked(BuildContext context, int index) {
    setIndex(index);
    Navigator.of(context).pop();
  }
}
