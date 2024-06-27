import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pizza/models/cart.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cart.items[index]),
                trailing: IconButton(
                  icon: Icon(Ionicons.md_trash),
                  onPressed: () {
                    cart.removeItem(cart.items[index]);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}