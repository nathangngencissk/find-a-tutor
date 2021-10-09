import 'package:flutter/material.dart';

class CartService with ChangeNotifier {
  List cart;
  double total;

  CartService() {
    cart = [];
    total = 0.0;
  }

  void addToCart(Map item) {
    for (var element in cart) {
      if (element["id"] == item["id"]) {
        return;
      }
    }
    cart.add(item);
    total += item['price'];
    notifyListeners();
  }

  void removeFromCart(Map item) {
    cart.removeWhere((i) => i['id'] == item['id']);
    total -= item['price'];
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    total = 0.0;
    notifyListeners();
  }

  List getCartIds() {
    List cartIds = [];
    for (var element in cart) {
      cartIds.add(element['id']);
    }
    return cartIds;
  }
}
