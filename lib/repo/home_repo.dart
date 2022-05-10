import 'package:grocery/models/product_model.dart';

import '../datasource/data_client.dart';

class HomeRepository {
  static Future<ProductModel> getAllProducts() async {
    return ProductModel.fromJson(await DataClient.getDataSrc("products.json"));
  }
}
