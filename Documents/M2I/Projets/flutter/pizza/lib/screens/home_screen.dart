import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pizzas = [];
  List filteredPizzas = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPizzas();
    searchController.addListener(_filterPizzas);
  }

  Future<void> fetchPizzas() async {
    var response = await Dio().get('https://pizzas.shrp.dev/items/pizzas');
    setState(() {
      pizzas = response.data['data'];
      filteredPizzas = pizzas;
      isLoading = false;
    });
  }

  void _filterPizzas() {
    setState(() {
      filteredPizzas = pizzas
          .where((pizza) =>
              pizza['name']
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des pizzas'),
        actions: [
          IconButton(
            icon: Icon(Ionicons.md_cart),
            onPressed: () {
              context.go('/cart');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher une pizza ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Ionicons.md_search),
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: filteredPizzas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    'https://pizzas.shrp.dev/assets/${filteredPizzas[index]['image']}',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(filteredPizzas[index]['name']),
                  subtitle: Text('Price: \$${filteredPizzas[index]['price']}'),
                  onTap: () {
                    context.go('/details/${filteredPizzas[index]['id']}');
                  },
                );
              },
            ),
    );
  }
}