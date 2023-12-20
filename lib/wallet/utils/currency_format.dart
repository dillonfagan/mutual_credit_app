import 'package:intl/intl.dart';

class CurrencyString {
  const CurrencyString({
    required this.major,
    required this.minor,
    required this.separator,
  });

  final String major;
  final String minor;
  final String separator;
}

extension CurrencyFormatting on double {
  CurrencyString toDecimalCurrencyString() {
    final numberFormat = NumberFormat.decimalPatternDigits(decimalDigits: 2);
    final balanceText = numberFormat.format(abs());
    final balanceTextPieces = balanceText.split('.');

    return CurrencyString(
      major: balanceTextPieces[0],
      minor: balanceTextPieces[1],
      separator: '.',
    );
  }

  CurrencyString toTimeCurrencyString() {
    final numberFormat = NumberFormat.decimalPatternDigits(decimalDigits: 2);
    final balanceText = numberFormat.format(abs());
    final balanceTextPieces = balanceText.split('.');

    final whole = truncate();
    final remainder = ((this - whole) * 60).toInt().abs();
    final minor = '$remainder${remainder == 0 ? '0' : ''}';

    return CurrencyString(
      major: balanceTextPieces[0],
      minor: minor,
      separator: ':',
    );
  }
}
