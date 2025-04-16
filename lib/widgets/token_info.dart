import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trading_view/providers/trade_provider.dart';

class TokenInfo extends ConsumerWidget {
  const TokenInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final candles = ref.watch(tradeProvider);
    final formatter = NumberFormat.compact();

    final low = candles.isEmpty ? 0.0 : candles.map((c) => c.low).reduce((a, b) => a < b ? a : b);
    final high = candles.isEmpty ? 0.0 : candles.map((c) => c.high).reduce((a, b) => a > b ? a : b);
    final volume = candles.isEmpty ? 0 : candles.map((c) => c.volume).reduce((a, b) => a + b);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoItem('24h Low', low),
          _buildInfoItem('24h High', high),
          _buildInfoItem('Vol', volume.toDouble(), formatter: formatter),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, double value, {NumberFormat? formatter}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Text(
          formatter?.format(value) ?? value.toStringAsFixed(4),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}