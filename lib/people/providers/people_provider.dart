import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutual_credit_app/people/models/person_model.dart';

final people = [
  const PersonModel(name: 'Alice'),
  const PersonModel(name: 'Bob'),
];

final peopleProvider = Provider<List<PersonModel>>((ref) {
  return people.toList();
});
