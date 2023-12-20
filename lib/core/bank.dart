import 'bank_interface.dart';
import 'exchange_record.dart';

class Bank implements BankInterface {
  const Bank({required this.bank});

  final BankInterface bank;

  @override
  Future<double> balance({
    required String owner,
    required String currency,
  }) {
    return bank.balance(
      owner: owner,
      currency: currency,
    );
  }

  @override
  Future<Iterable<ExchangeRecord>> exchanges({
    required String owner,
  }) {
    return bank.exchanges(owner: owner);
  }

  @override
  Future<void> send({
    required String from,
    required String to,
    required String currency,
    required double amount,
    String? memo,
  }) {
    return bank.send(
      from: from,
      to: to,
      currency: currency,
      amount: amount,
      memo: memo,
    );
  }
}
