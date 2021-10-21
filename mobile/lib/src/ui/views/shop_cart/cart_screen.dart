import 'package:find_a_tutor/src/services/cart.dart';
import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/views/shop_cart/cartBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  AnimationController animationController;
  CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "Seu carrinho",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            letterSpacing: 0.27,
            color: AppTheme.darkerText,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Builder(
        builder: (context) {
          return ListView(
            children: <Widget>[
              Consumer<CartService>(
                builder: (context, cartService, child) => ListView.builder(
                  itemCount: cartService.cart.length,
                  padding: const EdgeInsets.only(top: 8),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    animationController.forward();
                    return Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                right: 8, left: 8, top: 8, bottom: 8),
                            width: 100,
                            height: 58,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                              color: Colors.blue.shade200,
                              image: DecorationImage(
                                image: NetworkImage(
                                    cartService.cart[index]['picture']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    cartService.cart[index]['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20,
                                      letterSpacing: 0.27,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "R\$${cartService.cart[index]['price'].toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                            letterSpacing: 0.27,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            flex: 100,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 10, top: 8),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      color: Colors.red),
                                ),
                                onTap: () {
                                  cartService
                                      .removeFromCart(cartService.cart[index]);
                                }),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              footer(context)
            ],
          );
        },
      ),
    );
  }

  footer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Consumer<CartService>(
                  builder: (context, cartService, child) => Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Text(
                          "Total (${cartService.cart.length}) :",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            letterSpacing: 0.27,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      )),
              Consumer<CartService>(
                builder: (context, cartService, child) => Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Text(
                    "R\$${cartService.total.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      letterSpacing: 0.27,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 30,
          ),
          Consumer<CartService>(
              builder: (context, cartService, child) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity,
                          60), // double.infinity is the width and 30 is the height
                    ),
                    onPressed: cartService.cart.length > 0
                        ? () async {
                            List cartIds = cartService.getCartIds();
                            String checkoutLink = await cartBloc.createPayment(
                                cartIds, cartService.total.toString());
                            if (await canLaunch(checkoutLink)) {
                              await launch(checkoutLink);
                            } else {
                              throw 'Could not launch $checkoutLink';
                            }
                            cartService.clearCart();
                            Navigator.of(context).pop();
                          }
                        : null,
                    child: Text(
                      "Confirmar",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        letterSpacing: 0.27,
                        color: Colors.white,
                      ),
                    ),
                  )),
        ],
      ),
      margin: EdgeInsets.only(top: 10, bottom: 25),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "ITENS ADICIONADOS: ",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,
          letterSpacing: 0.27,
          color: Colors.black.withOpacity(0.7),
        ),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle() {
    return Consumer<CartService>(
      builder: (context, cartService, child) => Container(
        alignment: Alignment.topLeft,
        child: Text(
          "Total(${cartService.cart.length}) Items",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            letterSpacing: 0.27,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        margin: EdgeInsets.only(left: 12, top: 4),
      ),
    );
  }
}
