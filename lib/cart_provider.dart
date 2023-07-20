import 'package:cart_app/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_model.dart';

class CartProvider with ChangeNotifier{

  DBHelper db=DBHelper();
  int _counter = 0;
  int get counter =>counter;



  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getData () async{
    _cart = db.getCartList();
    return _cart;
  }

  late Future<List<Cart>> _wishlist;
  Future<List<Cart>> get wishlist => _wishlist;

  Future<List<Cart>> getWishlistData () async{
    _wishlist = db.getWishlist();
    return _wishlist;
  }

  void _setPrefItems()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();//sharedpreference is a localstorage
    prefs.setInt('cart_item', _counter);

    notifyListeners();
  }

  //Cart Product
  void _getPrefItems()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   _counter = prefs.getInt('cart_item') ?? 0;

    notifyListeners();
  }



  void addCounter (){
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter (){
    _getPrefItems();
    return _counter;
  }





}