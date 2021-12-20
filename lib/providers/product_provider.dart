import 'package:flutter/material.dart';
import 'product.dart';


class ProductsProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imgUrl:
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imgUrl:
      'https://www.myar.pk/wp-content/uploads/2020/07/mst4HG0.jpg',
    ),
    Product(
      id: 'p3',
      title: 'A pan',
      description: 'Prepare any meal you want.',
      price: 50.99,
      imgUrl:
      'https://www.ubuy.com.bd/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvODE5aHpaSUZOdUwuX0FDX1NMMTUwMF8uanBn.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Laptop',
      description: 'best product',
      price: 200.99,
      imgUrl:
      'https://m.media-amazon.com/images/I/71h6PpGaz9L._AC_SL1500_.jpg',
    ),
  ];



  List<Product> get items {
    return [..._items];
  }


  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFav).toList();
  }



  Product findById(String id){
    return _items.firstWhere((prod) => prod.id == id);
  }



  void addProduct(){
    notifyListeners();
  }
}