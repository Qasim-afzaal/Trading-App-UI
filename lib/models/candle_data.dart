class CandleData {
  final int timestamp;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;

  CandleData({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });
}