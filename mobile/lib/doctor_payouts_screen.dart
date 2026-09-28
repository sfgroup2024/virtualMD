// Doctor Payouts screen — Doctor app. Shows a doctor their pending balance
// and lets them search past payouts and request an early payout.
//
// This mirrors a real screen in our doctor mobile app. It's a simplified,
// self-contained version — the real one is wired to our actual API client
// and auth, this one uses a fake in-memory data source so it runs without
// any backend.

import 'dart:async';
import 'package:flutter/material.dart';

class Payout {
  final String id;
  final double amount;
  final String status;
  Payout({required this.id, required this.amount, required this.status});
}

class DoctorApiClient {
  Future<List<Payout>> fetchPayouts(String query) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final all = [
      Payout(id: 'p1', amount: 500, status: 'completed'),
      Payout(id: 'p2', amount: 750, status: 'completed'),
      Payout(id: 'p3', amount: 600, status: 'pending'),
    ];
    if (query.isEmpty) return all;
    return all.where((p) => p.status.contains(query)).toList();
  }

  Future<void> requestPayout() async {
    await Future.delayed(const Duration(milliseconds: 900));
  }
}

class DoctorPayoutsScreen extends StatefulWidget {
  const DoctorPayoutsScreen({super.key});

  @override
  State<DoctorPayoutsScreen> createState() => _DoctorPayoutsScreenState();
}

class _DoctorPayoutsScreenState extends State<DoctorPayoutsScreen> {
  final _api = DoctorApiClient();
  final _searchController = TextEditingController();

  List<Payout> _payouts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load('');
    _searchController.addListener(() => _load(_searchController.text));
  }

  Future<void> _load(String query) async {
    setState(() => _loading = true);
    final results = await _api.fetchPayouts(query);
    setState(() {
      _payouts = results;
      _loading = false;
    });
  }

  Future<void> _onRequestPayoutPressed() async {
    await _api.requestPayout();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payout requested')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Payouts')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Filter by status',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _payouts.length,
                    itemBuilder: (context, i) {
                      final p = _payouts[i];
                      return ListTile(
                        title: Text('₱${p.amount.toStringAsFixed(2)}'),
                        subtitle: Text(p.status),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: _onRequestPayoutPressed,
              child: const Text('Request Early Payout'),
            ),
          ),
        ],
      ),
    );
  }
}
