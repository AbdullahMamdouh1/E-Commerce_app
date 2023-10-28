



import 'package:abdullah1/Provider/Cart.dart';
import 'package:abdullah1/Screens/checkout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class appbar extends StatelessWidget {
  const appbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aaa =  Provider.of<Cart?>(context);
    return Row(
      children: [
        Stack(
          children: [
            Positioned(
              left: 1,
              bottom: 25,
              child: Container(
                child: Text( "${aaa?.selectedProdcts.length} ",
                    style:
                    TextStyle(color: Colors.black, fontSize: 15)),
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  CheckOut(),
                    ),
                  );
                },
                icon: Icon(Icons.add_shopping_cart)),
          ],
        ),
        Text(
          '\$  ${aaa?.price}',
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }
}