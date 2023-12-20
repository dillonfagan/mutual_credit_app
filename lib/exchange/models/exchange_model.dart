import 'package:mutual_credit_app/people/models/person_model.dart';
import 'currency_model.dart';

class ExchangeModel {
  const ExchangeModel({
    required this.sender,
    required this.receiver,
    required this.currency,
    required this.amount,
    required this.memo,
  });

  final PersonModel sender;
  final PersonModel receiver;
  final CurrencyModel currency;
  final double amount;
  final String? memo;
}
