class WalletModel {
  const WalletModel({
    required this.symbol,
    required this.balance,
    this.remainderType = RemainderType.decimal,
  });

  final String symbol;
  final double balance;
  final RemainderType remainderType;
}

enum RemainderType {
  decimal,
  fraction,
}
