import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trading_view/providers/trade_provider.dart';

final priceProvider = Provider<double>((ref) {
  final candles = ref.watch(tradeProvider);
  return candles.isNotEmpty ? candles.last.close : 0.0;
});