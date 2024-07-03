import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartModel extends ChangeNotifier {
  List<String> _items = [];
  
  int get count => _items.length;
  List<String> get items => _items;

  CartModel() {
    loadCart();
  }

  void addItem(String item) {
    _items.add(item);
    saveCart();
    notifyListeners();
  }

  void removeItem(String item) {
    _items.remove(item);
    saveCart();
    notifyListeners();
  }

  void loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    _items = prefs.getStringList('cart') ?? [];
    notifyListeners();
  }

  void saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('cart', _items);
  }
}
