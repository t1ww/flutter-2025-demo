// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/cart.dart';

class MyPurchase extends StatelessWidget {
  const MyPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Purchase Summary',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 247, 220),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Thank you for your purchase!",
                textScaler: TextScaler.linear(1.5),
              ),
              const Padding(
                padding: EdgeInsets.all(4),
                child: Divider(height: 4, color: Colors.black),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Items you purchased:",
                  textScaler: TextScaler.linear(1.2),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _CartList(),
                ),
              ),
              _CartTotal(),
              FilledButton(
                onPressed: () {
                  final cart = context.read<CartModel>();
                  cart.clear();
                  context.go('/catalog');
                },
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                child: const Text('Back to home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.titleLarge;
    var cart = context.watch<CartModel>();

    if (cart.items.isEmpty) {
      // Show a message when the cart is empty
      return Center(child: Text("Your cart is empty", style: itemNameStyle));
    }

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder:
          (context, index) => ListTile(
            leading: const Icon(Icons.done),
            title: Text(cart.items[index].name, style: itemNameStyle),
          ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          children: [
            // Another way to listen to a model's change is to include
            // the Consumer widget. This widget will automatically listen
            // to CartModel and rerun its builder on every change.
            //
            // The important thing is that it will not rebuild
            // the rest of the widgets in this build method.
            Consumer<CartModel>(
              builder:
                  (context, cart, child) => Text(
                    'Total: ${cart.totalPrice}',
                    textScaler: TextScaler.linear(1.1),
                  ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
