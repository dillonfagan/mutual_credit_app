import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutual_credit_app/app/providers/bank_provider.dart';
import 'package:mutual_credit_app/exchange/models/currency_model.dart';
import 'package:mutual_credit_app/people/models/person_model.dart';
import '../models/exchange_model.dart';

final List<ExchangeModel> exchanges = [];

final exchangesProvider = Provider<Future<List<ExchangeModel>>>((ref) async {
  final bank = ref.watch(bankProvider);
  final exchanges = await bank.exchanges(owner: 'me');

  return exchanges
      .map((e) => ExchangeModel(
            sender: PersonModel(name: e.from),
            receiver: PersonModel(name: e.to),
            currency:
                CurrencyModel.values.firstWhere((v) => v.name == e.currency),
            amount: e.amount,
            memo: e.memo,
          ))
      .toList();
});
