import 'bank_interface.dart';
import 'exchange_record.dart';

class FakeMutualCreditBank implements BankInterface {
  // Currency -> Owner -> Balance
  final _balances = <String, Map<String, double>>{
    'usd': <String, double>{},
    'hour': <String, double>{},
  };

  // Owner -> Exchanges
  final _exchanges = <String, List<ExchangeRecord>>{};

  @override
  Future<double> balance({
    required String owner,
    required String currency,
  }) async {
    return _balances[currency]![owner] ?? 0;
  }

  @override
  Future<Iterable<ExchangeRecord>> exchanges({
    required String owner,
  }) async {
    return _exchanges[owner] ?? [];
  }

  @override
  Future<void> send({
    required String from,
    required String to,
    required String currency,
    required double amount,
    String? memo,
  }) async {
    final fromBalance = _balances[currency]![from] ?? 0;
    _balances[currency]![from] = fromBalance - amount;

    final toBalance = _balances[currency]![to] ?? 0;
    _balances[currency]![to] = toBalance + amount;

    final record = ExchangeRecord(
      from: from,
      to: to,
      currency: currency,
      amount: amount,
      memo: memo,
    );

    _exchanges[from] = (_exchanges[from] ?? [])..add(record);
    _exchanges[to] = (_exchanges[to] ?? [])..add(record);
  }
}
