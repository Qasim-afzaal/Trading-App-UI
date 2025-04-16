import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trading_view/models/candle_data.dart';
import 'package:trading_view/providers/interval_provider.dart';
import 'package:trading_view/services/mock_data_service.dart';

final tradeProvider = StateNotifierProvider<TradeNotifier, List<CandleData>>((ref) {
  return TradeNotifier(ref);
});

class TradeNotifier extends StateNotifier<List<CandleData>> {
  final Ref ref;
  TradeNotifier(this.ref) : super([]) {
    _init();
  }

  void _init() {
    ref.listen<String>(intervalProvider, (_, interval) => _updateData(interval));
    _updateData(ref.read(intervalProvider));
  }

  void _updateData(String interval) {
    state = MockDataService.generateMockData(interval);
  }

  void refresh() => _updateData(ref.read(intervalProvider));
}