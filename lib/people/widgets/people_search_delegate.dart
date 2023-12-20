import 'package:flutter/material.dart';
import 'package:mutual_credit_app/people/models/person_model.dart';

class PeopleSearchDelegate extends SearchDelegate<PersonModel?> {
  PeopleSearchDelegate({required this.people});

  final List<PersonModel> people;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
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
    final results = people
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].name),
          onTap: () {
            Navigator.of(context).pop(results[index]);
          },
        );
      },
      itemCount: results.length,
    );
  }
}
