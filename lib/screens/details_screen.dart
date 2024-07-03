import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../models/cart.dart';

class DetailsScreen extends StatefulWidget {
  final String id;

  DetailsScreen({required this.id});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Map pizza = {};

  @override
  void initState() {
    super.initState();
    fetchPizzaDetails();
  }

  void fetchPizzaDetails() async {
    try {
      var response = await Dio().get('https://pizzas.shrp.dev/items/pizzas/${widget.id}');
      setState(() {
        pizza = response.data['data'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (pizza.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Pizza Details'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(pizza['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network('https://pizzas.shrp.dev/assets/${pizza['image']}'),
            SizedBox(height: 16.0),
            Text(
              pizza['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Price: \$${pizza['price']}'),
            Text('Base: ${pizza['base']}'),
            SizedBox(height: 16.0),
            Text(
              'Ingredients',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            for (var ingredient in pizza['ingredients'])
              Text(ingredient),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).addItem(pizza['name']);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${pizza['name']} a été ajouté au panier'),
                ));
              },
              child: Text('Ajouter au panier'),
            ),
          ],
        ),
      ),
    );
  }
}