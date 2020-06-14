import 'package:dio/dio.dart';
import 'package:kulina_submission_test/constant/constant.dart';
import 'package:kulina_submission_test/models/product_model.dart';

class ProductService {
  Future<List<Product>> fetchAllProduct() async {
    try {
      final Response resp = await Dio().get("$API/products");
      final List<Product> products = [];

      (resp.data as List<dynamic>).forEach((element) {
        products.add(Product.fromJson(element));
      });

      return products;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
