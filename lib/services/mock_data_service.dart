import 'dart:math';

import 'package:trading_view/models/candle_data.dart';

class MockDataService {
  static List<CandleData> generateMockData(String interval) {
    final random = Random();
    double prevClose = 0.0050;
    List<CandleData> data = [];

    int count;
    Duration step;
    switch (interval) {
      case '1D':
        count = 30;
        step = const Duration(days: 1);
        break;
      case '1W':
        count = 12;
        step = const Duration(days: 7);
        break;
      case '1M':
        count = 12;
        step = const Duration(days: 30);
        break;
      case '1Y':
        count = 5;
        step = const Duration(days: 365);
        break;
      default:
        count = 30;
        step = const Duration(days: 1);
    }

    for (int i = 0; i < count; i++) {
      double open = prevClose + (random.nextDouble() - 0.5) * 0.001;
      double close = open + (random.nextDouble() - 0.5) * 0.001;
      double high = max(open, close) + random.nextDouble() * 0.0005;
      double low = min(open, close) - random.nextDouble() * 0.0005;
      low = low < 0 ? open : low;
      DateTime ts = DateTime.now().subtract(step * (count - i));

      data.add(
        CandleData(
          timestamp: ts.millisecondsSinceEpoch,
          open: open,
          high: high,
          low: low,
          close: close,
          volume: random.nextInt(50000) + 10000,
        ),
      );
      prevClose = close;
    }
    return data;
  }
}