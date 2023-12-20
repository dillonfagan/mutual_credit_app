import 'exchange_record.dart';

abstract interface class BankInterface {
  Future<void> send({
    required String from,
    required String to,
    required String currency,
    required double amount,
    String? memo,
  });

  Future<double> balance({
    required String owner,
    required String currency,
  });

  Future<Iterable<ExchangeRecord>> exchanges({
    required String owner,
  });
}
