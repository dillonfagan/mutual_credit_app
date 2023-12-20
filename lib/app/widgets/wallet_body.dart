import 'package:flutter/material.dart';
import 'package:mutual_credit_app/exchange/widgets/exchanges_view.dart';
import 'package:mutual_credit_app/wallet/widgets/wallet_view.dart';

class WalletBody extends StatelessWidget {
  const WalletBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WalletView(),
            SizedBox(height: 48),
            ExchangesView(),
          ],
        ),
      ),
    );
  }
}
