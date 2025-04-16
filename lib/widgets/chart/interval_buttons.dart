import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trading_view/providers/interval_provider.dart';

class IntervalButtons extends ConsumerWidget {
  const IntervalButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInterval = ref.watch(intervalProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ['1D', '1W', '1M', '1Y'].map((interval) {
          return ElevatedButton(
            onPressed: () => ref.read(intervalProvider.notifier).state = interval,
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedInterval == interval
                  ? Colors.blue
                  : Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              interval,
              style: TextStyle(
                color: selectedInterval == interval ? Colors.white : Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}