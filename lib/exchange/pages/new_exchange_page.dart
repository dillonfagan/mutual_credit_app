import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutual_credit_app/app/providers/bank_provider.dart';
import 'package:mutual_credit_app/exchange/models/currency_model.dart';
import 'package:mutual_credit_app/exchange/models/exchange_type_model.dart';
import 'package:mutual_credit_app/exchange/providers/currencies_provider.dart';
import 'package:mutual_credit_app/exchange/providers/exchanges_provider.dart';
import 'package:mutual_credit_app/exchange/widgets/currencies_search_delegate.dart';
import 'package:mutual_credit_app/people/providers/people_provider.dart';
import 'package:mutual_credit_app/people/widgets/people_search_delegate.dart';
import 'package:mutual_credit_app/wallet/providers/wallet_provider.dart';

class NewExchangePage extends ConsumerStatefulWidget {
  const NewExchangePage({super.key});

  @override
  ConsumerState<NewExchangePage> createState() => _NewExchangePageState();
}

class _NewExchangePageState extends ConsumerState<NewExchangePage> {
  final _formKey = GlobalKey<FormState>();

  final personController = TextEditingController();
  final currencyController =
      TextEditingController(text: CurrencyModel.usd.name.toUpperCase());
  final amountController = TextEditingController();
  final memoController = TextEditingController();

  ExchangeTypeModel exchangeType = ExchangeTypeModel.request;
  CurrencyModel currency = CurrencyModel.usd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Exchange'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SegmentedButton(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(
                      value: ExchangeTypeModel.request,
                      label: Text('Request'),
                    ),
                    ButtonSegment(
                      value: ExchangeTypeModel.send,
                      label: Text('Send'),
                    ),
                  ],
                  selected: {exchangeType},
                  onSelectionChanged: (values) {
                    setState(() {
                      exchangeType = values.first;
                    });
                  },
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
                    textStyle: MaterialStatePropertyAll(
                        Theme.of(context).textTheme.titleLarge),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: personController,
                onTap: () async {
                  final people = ref.read(peopleProvider);
                  final person = await showSearch(
                      context: context,
                      delegate: PeopleSearchDelegate(people: people));

                  if (person != null) {
                    personController.text = person.name;
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'To',
                  labelText: 'To',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must choose a recipient';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: currencyController,
                onTap: () async {
                  final currencies = ref.read(currenciesProvider);
                  final currency = await showSearch(
                      context: context,
                      delegate:
                          CurrenciesSearchDelegate(currencies: currencies));

                  if (currency != null) {
                    this.currency = currency;
                    currencyController.text = currency.name.toUpperCase();
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Currency',
                  labelText: 'Currency',
                  prefixIcon: Icon(Icons.currency_exchange),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must choose a currency to exchange';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(
                  hintText: 'Amount',
                  labelText: 'Amount',
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Amount must be a positive number';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: memoController,
                decoration: const InputDecoration(
                  hintText: 'Memo',
                  labelText: 'Memo',
                  prefixIcon: Icon(Icons.notes),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          }

          final amount = double.parse(amountController.text);

          final bank = ref.read(bankProvider);
          bank.send(
            from: exchangeType == ExchangeTypeModel.request
                ? personController.text
                : 'me',
            to: exchangeType == ExchangeTypeModel.request
                ? 'me'
                : personController.text,
            currency: currency.name,
            amount: amount,
            memo: memoController.text,
          );

          ref.invalidate(exchangesProvider);
          ref.invalidate(walletProvider);

          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.send),
        label: Text(
            exchangeType == ExchangeTypeModel.request ? 'Request' : 'Send'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
