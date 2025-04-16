import 'package:flutter/material.dart';

class OrderBook extends StatelessWidget {
  const OrderBook({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text("0.005$i", style: const TextStyle(color: Colors.green)),
              Text("${(i + 1) * 1000} Vol",
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
        );
      }),
    );
  }
}