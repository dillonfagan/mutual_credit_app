import 'package:flutter/material.dart';
import 'package:mutual_credit_app/exchange/pages/new_exchange_page.dart';

import '../widgets/settings_body.dart';
import '../widgets/wallet_body.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentBodyIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const WalletBody(),
        const SettingsBody(),
      ][_currentBodyIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.account_balance_outlined),
            selectedIcon: Icon(Icons.account_balance),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onDestinationSelected: (index) {
          setState(() => _currentBodyIndex = index);
        },
        selectedIndex: _currentBodyIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const NewExchangePage();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
