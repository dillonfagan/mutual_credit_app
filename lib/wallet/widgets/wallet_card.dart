import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mutual_credit_app/wallet/utils/currency_format.dart';

import '../models/wallet_model.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    super.key,
    required this.symbol,
    required this.balance,
    required this.remainderType,
  });

  final String symbol;
  final double balance;
  final RemainderType remainderType;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              symbol,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Balance',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 4),
                _BalanceText(
                  balance: balance,
                  remainderType: remainderType,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceText extends StatelessWidget {
  const _BalanceText({
    required this.balance,
    required this.remainderType,
  });

  final double balance;
  final RemainderType remainderType;

  String buildMinutes(double balance) {
    final whole = balance.truncate();
    final remainder = ((balance - whole) * 60).toInt().abs();
    return '$remainder${remainder == 0 ? '0' : ''}';
  }

  @override
  Widget build(BuildContext context) {
    final currencyString = remainderType == RemainderType.decimal
        ? balance.toDecimalCurrencyString()
        : balance.toTimeCurrencyString();

    final textStyle = GoogleFonts.getFont(
      'Noto Sans Mono',
      textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
          color: Theme.of(context).colorScheme.onBackground.withAlpha(120),
          fontWeight: FontWeight.w600),
    );

    final orangeTextStyle =
        textStyle.copyWith(color: Theme.of(context).primaryColor);

    return Text.rich(TextSpan(
      children: [
        if (balance != 0)
          TextSpan(
            text: balance.isNegative ? '-' : '+',
            style: orangeTextStyle,
          ),
        TextSpan(
          text: currencyString.major,
          style: orangeTextStyle,
        ),
        TextSpan(text: currencyString.separator),
        TextSpan(text: currencyString.minor),
      ],
      style: textStyle,
    ));
  }
}
