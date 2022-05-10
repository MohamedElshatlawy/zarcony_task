import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasource/data_client.dart';
import '../models/category_model.dart';
import '../models/product_model.dart' as product;

final groceryProvider =
    ChangeNotifierProvider<GroceryProvider>((ref) => GroceryProvider());

class GroceryProvider extends ChangeNotifier {
  CategoryModel? categories;
  product.ProductModel? products;
  List<product.Data> favProducts = [];
  List<product.Data> productsOfCategory = [];
  List<product.Data> card = [];
  double totalCard = 0.0;
  int amountOfProduct = 1;
  void notify() {
    notifyListeners();
  }

  Future<void> getCategories() async {
    try {
      var response = await DataClient.getDataSrc('category.json');
      categories = CategoryModel.fromJson(response);
    } catch (e) {
      print("Error ==> $e");
    }
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      var response = await DataClient.getDataSrc('products.json');
      products = product.ProductModel.fromJson(response);
    } catch (e) {
      print("Error ==> $e");
    }
    notifyListeners();
  }

  getProductsOfCategory({required int categoryId}) {
    products!.data!.forEach((element) {
      if (element.categoryId == categoryId) {
        productsOfCategory.add(element);
      }
    });
  }
}
