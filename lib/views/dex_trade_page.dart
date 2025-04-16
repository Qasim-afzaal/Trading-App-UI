import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trading_view/providers/price_provider.dart';
import 'package:trading_view/providers/trade_provider.dart';
import 'package:trading_view/widgets/buy_sell_buttons.dart';
import 'package:trading_view/widgets/chart/interval_buttons.dart';
import 'package:trading_view/widgets/chart/trade_chart.dart';
import 'package:trading_view/widgets/order_book.dart';
import 'package:trading_view/widgets/token_info.dart';
import 'package:trading_view/widgets/transactions_list.dart';

class DexTradePage extends ConsumerStatefulWidget {
  const DexTradePage({super.key});

  @override
  ConsumerState<DexTradePage> createState() => _DexTradePageState();
}

class _DexTradePageState extends ConsumerState<DexTradePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPrice = ref.watch(priceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI/USDT',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(tradeProvider.notifier).refresh(),
          ),
          TextButton(
            onPressed: () {},
            child: Text(currentPrice.toStringAsFixed(4)),
          ),
        ],
      ),
      body: Column(
        children: [
          const TokenInfo(),
          const IntervalButtons(),
          const SizedBox(height: 200, child: TradeChart()),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: "Order Book"),
              Tab(text: "Transactions"),
              Tab(text: "Info"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                OrderBook(),
                TransactionsList(),
                _TokenInfoTab(),
              ],
            ),
          ),
          const BuySellButtons(),
        ],
      ),
    );
  }
}

class _TokenInfoTab extends StatelessWidget {
  const _TokenInfoTab();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
}