import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutual_credit_app/core/bank.dart';
import 'package:mutual_credit_app/core/fake_mutual_credit_bank.dart';

final bankProvider = Provider((ref) => Bank(bank: FakeMutualCreditBank()));
