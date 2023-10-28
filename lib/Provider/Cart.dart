import 'package:abdullah1/Screens/Home.dart';
import 'package:abdullah1/widget/Item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List selectedProdcts = [];
  double price = 0;
  add(item product) {
    selectedProdcts.add(product);
    price += product.price.round();
    notifyListeners();
  }
  delete(item product){
    selectedProdcts.remove(product);
    price -= product.price.round();
    notifyListeners();

  }
}









