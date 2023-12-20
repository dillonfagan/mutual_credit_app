import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutual_credit_app/wallet/models/wallet_model.dart';

import '../providers/wallet_provider.dart';
import 'wallet_card.dart';

class WalletView extends ConsumerWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref.watch(walletProvider),
        builder: (context, snapshot) {
          final wallets = snapshot.data ??
              const [
                WalletModel(symbol: 'USD', balance: 0),
                WalletModel(
                  symbol: 'HOUR',
                  balance: 0,
                  remainderType: RemainderType.fraction,
                ),
              ];

          return ListView.separated(
            itemBuilder: (context, index) {
              final wallet = wallets[index];
              return WalletCard(
                symbol: wallet.symbol,
                balance: wallet.balance,
                remainderType: wallet.remainderType,
              );
            },
            itemCount: wallets.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            shrinkWrap: true,
          );
        });
  }
}
