import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutual_credit_app/app/providers/bank_provider.dart';
import 'package:mutual_credit_app/exchange/models/currency_model.dart';
import 'package:mutual_credit_app/wallet/models/wallet_model.dart';

Map<CurrencyModel, WalletModel> walletMap = {
  CurrencyModel.usd: const WalletModel(symbol: 'USD', balance: 0),
  CurrencyModel.hour: const WalletModel(
    symbol: 'HOUR',
    balance: 0,
    remainderType: RemainderType.fraction,
  ),
};

void updateBalance(CurrencyModel currency, double delta) {
  if (currency == CurrencyModel.usd) {
    updateUsdBalance(delta);
  }

  if (currency == CurrencyModel.hour) {
    updateHourBalance(delta);
  }
}

void updateUsdBalance(double delta) {
  walletMap[CurrencyModel.usd] = WalletModel(
    symbol: 'USD',
    balance: walletMap[CurrencyModel.usd]!.balance + delta,
  );
}

void updateHourBalance(double delta) {
  walletMap[CurrencyModel.hour] = WalletModel(
    symbol: 'HOUR',
    balance: walletMap[CurrencyModel.hour]!.balance + delta,
    remainderType: RemainderType.fraction,
  );
}

final walletProvider = Provider<Future<List<WalletModel>>>((ref) async {
  final bank = ref.watch(bankProvider);
  return [
    WalletModel(
      symbol: 'USD',
      balance: await bank.balance(owner: 'me', currency: 'usd'),
    ),
    WalletModel(
      symbol: 'HOUR',
      balance: await bank.balance(owner: 'me', currency: 'hour'),
      remainderType: RemainderType.fraction,
    ),
  ];
});
