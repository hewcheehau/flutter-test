import 'package:myeg_flutter_test/core/network/product_api.dart';

class ProductRepository {
  final ProductApi productApi;

  ProductRepository({required this.productApi});

  Future<dynamic> getProductList() async {
    return productApi.getProductList();
  }
}
