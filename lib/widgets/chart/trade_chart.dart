import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interactive_chart/interactive_chart.dart' as ic; 
import 'package:intl/intl.dart';
import 'package:trading_view/providers/interval_provider.dart';
import 'package:trading_view/providers/trade_provider.dart';

class TradeChart extends ConsumerWidget {
  const TradeChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(tradeProvider);
    final interval = ref.watch(intervalProvider);

    
    final packageCandles = data.map((c) => ic.CandleData(
      timestamp: c.timestamp,
      open: c.open,
      high: c.high,
      low: c.low,
      close: c.close,
      volume: c.volume.toDouble(),    )).toList();

    return InteractiveViewer(
      panEnabled: true,
      scaleEnabled: true,
      maxScale: 5.0,
      minScale: 0.5,
      child: ic.InteractiveChart(
        candles: packageCandles, // Use converted list
        style: const ic.ChartStyle(
          priceGainColor: Colors.green,
          priceLossColor: Colors.red,
        ),
        timeLabel: (timestamp, visibleDataCount) {
          final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
          switch (interval) {
            case '1D':
              return DateFormat('dd MMM').format(date);
            case '1W':
              return 'W${DateFormat('w').format(date)}';
            case '1M':
              return DateFormat('MMM yy').format(date);
            case '1Y':
              return DateFormat('yyyy').format(date);
            default:
              return DateFormat('dd MMM').format(date);
          }
        },
        priceLabel: (price) => "\$${price.toStringAsFixed(4)}",
      ),
    );
  }
}