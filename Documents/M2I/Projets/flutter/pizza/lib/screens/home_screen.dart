import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pizzas = [];

  @override
  void initState() {
    super.initState();
    fetchPizzas();
  }

  void fetchPizzas() async {
    try {
      var response = await Dio().get('https://pizzas.shrp.dev/items/pizzas');
      setState(() {
        pizzas = response.data['data'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizza Napoli'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              context.go('/cart');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pizzas[index]['name']),
            subtitle: Text('Price: \$${pizzas[index]['price']}'),
            onTap: () {
              context.go('/details/${pizzas[index]['id']}');
            },
          );
        },
      ),
    );
  }
}