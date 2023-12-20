class ExchangeRecord {
  const ExchangeRecord({
    required this.from,
    required this.to,
    required this.currency,
    required this.amount,
    required this.memo,
  });

  final String from;
  final String to;
  final String currency;
  final double amount;
  final String? memo;
}
