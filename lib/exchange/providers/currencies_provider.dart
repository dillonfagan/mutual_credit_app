import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutual_credit_app/exchange/models/currency_model.dart';

final currenciesProvider =
    Provider<List<CurrencyModel>>((ref) => CurrencyModel.values);
