import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: List.generate(8, (i) {
        return ListTile(
          title: Text(
            "Buy",
            style: TextStyle(color: i.isEven ? Colors.green : Colors.red),
          ),
          subtitle: Text("Price: 0.005$i - Volume: ${1000 + i * 100}"),
          trailing: Text("Address: 0x...$i"),
        );
      }),
    );
  }
}