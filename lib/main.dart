import 'dart:math';

import 'package:flutter/material.dart';

import 'package:interactive_chart/interactive_chart.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Candle Stick Chart UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DexTradePage(),
    );
  }
}

class DexTradePage extends StatefulWidget {
  const DexTradePage({Key? key}) : super(key: key);

  @override
  State<DexTradePage> createState() => _DexTradePageState();
}

class _DexTradePageState extends State<DexTradePage>
    with SingleTickerProviderStateMixin {
  final List<CandleData> _data = [];
  late TabController _tabController;
  String _selectedInterval = '1D';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _updateData(_selectedInterval);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _updateData(String interval) {
    setState(() {
      _selectedInterval = interval;
      _data.clear();
      _data.addAll(_generateMockData(interval));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI/USDT',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [TextButton(onPressed: () {}, child: const Text("0.0002"))],
      ),
      body: Column(
        children: [
          _buildTokenInfo(),
          _buildIntervalButtons(),
          SizedBox(height: 200, child: _buildChart()),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: "Entrusted order"),
              Tab(text: "Txs"),
              Tab(text: "Info"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderBook(),
                _buildTransactions(),
                _buildInfo(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "Buy",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      "Sell",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTokenInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("24h Low: 0.0000"),
          Text("24h High: 0.0000"),
          Text("Vol: 0.0000"),
        ],
      ),
    );
  }

  Widget _buildIntervalButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ['1D', '1W', '1M', '1Y'].map((interval) {
          return ElevatedButton(
            onPressed: () => _updateData(interval),
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedInterval == interval
                  ? Colors.blue
                  : Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              interval,
              style: TextStyle(
                color:
                    _selectedInterval == interval ? Colors.white : Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChart() {
    return InteractiveViewer(
      panEnabled: true,
      scaleEnabled: true,
      maxScale: 5.0,
      minScale: 0.5,
      child: InteractiveChart(
        candles: _data,
        style: ChartStyle(
          priceGainColor: Colors.green,
          priceLossColor: Colors.red,
        ),
        timeLabel: (timestamp, visibleDataCount) {
          final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
          switch (_selectedInterval) {
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

  Widget _buildOrderBook() {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: List.generate(6, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Buy ${1000 + i * 500}",
                  style: const TextStyle(color: Colors.green)),
              Text("0.005${i}", style: const TextStyle(color: Colors.green)),
              Text("${(i + 1) * 1000} Vol",
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTransactions() {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: List.generate(8, (i) {
        return ListTile(
          title: Text(
            "Buy",
            style: TextStyle(color: i.isEven ? Colors.green : Colors.red),
          ),
          subtitle: Text("Price: 0.005${i} - Volume: ${1000 + i * 100}"),
          trailing: Text("Address: 0x...${i}"),
        );
      }),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Token Info", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Mainnet: SUI"),
          Text("Total Supply: 1,000,000"),
          Text("Publish Time: 2025-2-12 17:34"),
          Text("Contract Address: 0x5e4d...0686"),
          SizedBox(height: 16),
          Text(
            "About AI: Sleepless.AI is a Web3-AI companion game platform. "
            "Its goal is to utilize artificial intelligence and blockchain technology "
            "to create the next generation of gamified companionship.",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }

  List<CandleData> _generateMockData(String interval) {
    final random = Random();
    double prevClose = 0.0050;
    List<CandleData> data = [];

    int count;
    Duration step;
    switch (interval) {
      case '1D':
        count = 30;
        step = Duration(days: 1);
        break;
      case '1W':
        count = 12;
        step = Duration(days: 7);
        break;
      case '1M':
        count = 12;
        step = Duration(days: 30);
        break;
      case '1Y':
        count = 5;
        step = Duration(days: 365);
        break;
      default:
        count = 30;
        step = Duration(days: 1);
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
