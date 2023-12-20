import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutual_credit_app/theme/theme.dart';

import 'app/pages/main_page.dart';

void main() {
  runApp(const ProviderScope(child: MutualCreditApp()));
}

class MutualCreditApp extends StatelessWidget {
  const MutualCreditApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mutual Credit',
      theme: appTheme,
      home: const MainPage(title: 'Wallet'),
    );
  }
}
