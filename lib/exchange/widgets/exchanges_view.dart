import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutual_credit_app/exchange/models/exchange_model.dart';

import '../providers/exchanges_provider.dart';
import '../utils/currency_map.dart';

class ExchangesView extends ConsumerWidget {
  const ExchangesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(exchangesProvider),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final exchanges = snapshot.data!.reversed.toList();

        if (exchanges.isEmpty) {
          return const Center(child: Text('No recent activity.'));
        }

        return Column(
          children: [
            Text(
              'Activity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.separated(
              itemBuilder: (context, index) {
                final exchange = exchanges[index];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        exchange.sender.name == 'me'
                            ? Icon(
                                Icons.arrow_upward,
                                color: Theme.of(context).primaryColor,
                              )
                            : const Icon(Icons.arrow_downward),
                        const SizedBox(width: 16),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 150,
                          ),
                          child: _ExchangeText(exchange: exchange),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: exchanges.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              shrinkWrap: true,
            ),
          ],
        );
      },
    );
  }
}

class _ExchangeText extends StatelessWidget {
  const _ExchangeText({required this.exchange});

  final ExchangeModel exchange;

  @override
  Widget build(BuildContext context) {
    final bolderTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.w600);

    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: 'You'),
          TextSpan(
              text: exchange.sender.name == 'me' ? ' sent ' : ' received '),
          TextSpan(
            text: currencyMap[exchange.currency],
            style: bolderTextStyle,
          ),
          TextSpan(text: exchange.sender.name == 'me' ? ' to ' : ' from '),
          TextSpan(
            text: exchange.sender.name == 'me'
                ? exchange.receiver.name
                : exchange.sender.name,
            style: bolderTextStyle,
          ),
          if (exchange.memo?.isNotEmpty ?? false) ...[
            const TextSpan(text: ' for '),
            TextSpan(
              text: exchange.memo,
              style: bolderTextStyle,
            ),
          ],
        ],
      ),
      overflow: TextOverflow.fade,
    );
  }
}
