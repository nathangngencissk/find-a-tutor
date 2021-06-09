// import 'package:find_a_tutor/src/ui/views/shop_cart/component/body.dart';
import 'package:flutter/material.dart';
// import 'component/check_out_card.dart';

import 'package:flutter/cupertino.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Seu carrinho"),
          ],
        ),
        centerTitle: true,
      ),
    );
  }
}
//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       title: Column(
//         children: [
//           Text(
//             "Your Cart",
//             style: TextStyle(color: Colors.black),
//           ),
//           Text(
//             "${demoCarts.length} items",
//             style: Theme.of(context).textTheme.caption,
//           ),
//         ],
//       ),
//     );
//   }
// }
