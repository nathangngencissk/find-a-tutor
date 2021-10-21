import 'package:find_a_tutor/src/ui/views/myCourses/myCourseBloc.dart';
import 'package:flutter/material.dart';

class CartService with ChangeNotifier {
  List cart;
  double total;
  List userCourses;

  CartService() {
    cart = [];
    total = 0.0;
    userCourses = [];
  }

  void getUserCourses() {
    MyHomePageBloc myHomePageBloc = MyHomePageBloc();
    myHomePageBloc.getMyCourses().then((courses) => {
          courses.forEach((element) {
            userCourses.add(element["id"]);
          })
        });
    notifyListeners();
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
