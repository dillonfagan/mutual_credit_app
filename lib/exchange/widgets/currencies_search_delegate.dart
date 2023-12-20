import 'package:flutter/material.dart';
import 'package:mutual_credit_app/exchange/models/currency_model.dart';

class CurrenciesSearchDelegate extends SearchDelegate<CurrencyModel?> {
  CurrenciesSearchDelegate({required this.currencies});

  final List<CurrencyModel> currencies;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildListView(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildListView(context);
  }

  Widget buildListView(BuildContext context) {
    final results = currencies
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].name.toUpperCase()),
          onTap: () {
            Navigator.of(context).pop(results[index]);
          },
        );
      },
      itemCount: results.length,
    );
  }
}
